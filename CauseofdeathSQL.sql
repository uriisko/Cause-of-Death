
--Israel, Males, 2019 Top 10 causes (number of deaths per 100K population)

select top 10*
from Cause
where Year = 2019 and Sex = 'MLE' and Country = 'ISR'

-- Israel, Females, 2019 Top 10 causes (number of deaths per 100K population)

select top 10*
from Cause
where Year = 2019 and Sex = 'FMLE' and Country = 'ISR'

--Israel, Both Sex, 2019, top 10 causes (number of deaths per 100K population) by Category

select top 10 category, sum(val_deaths_rate100K_Numeric) as deaths_per_100K
from Israel_BTSX
where VAL_DEATHS_RATE100K_NUMERIC <> 0
Group by Category
Order by 2 desc

-- Israel, Both Sex, Malignant neoplasms & Cardiovascular diseases

select Dim_year_code, Category, Sum(deaths_rate100k) as deaths
from ISR00_19
where Category = 'Malignant neoplasms'
group by Dim_year_code, Category


select Dim_year_code, Category, Sum(deaths_rate100k) as deaths
from ISR00_19
where Category = 'Cardiovascular diseases'
group by Dim_year_code, Category

-- World comparison, Deaths from Cardiovascular dieases in 2019

select A.dim_country_code, A.category, sum(val_deaths_rate100k_numeric) as Total_deaths
from (
select*
from world
where category = 'cardiovascular diseases') A
group by A.dim_country_code, A.category
order by 3 desc

-- World comparison, Deaths from Malignant neoplasms in 2019

select A.dim_country_code, A.category, sum(val_deaths_rate100k_numeric) as Total_deaths
from (
select*
from world
where category = 'malignant neoplasms') A
group by A.dim_country_code, A.category
order by 3 desc

-- cause by age group

select A.dim_agegroup_code, A.dim_ghecause_title,A.val_deaths_rate100k_numeric 
from (
select dim_agegroup_code, dim_ghecause_title, val_deaths_rate100k_numeric, ROW_NUMBER() over (partition by dim_agegroup_code order by val_deaths_rate100k_numeric desc) RN
from by_age ) A
where A.RN = 1

-- number of deaths of males from stroke per 100,000 population

select Country, deaths_per_100K, cast((deaths_per_100K / 100000)*100 as nvarchar) + '%'
from Cause
where Cause = 'stroke' and Year = 2019 and Sex = 'MLE'
order by 2 desc


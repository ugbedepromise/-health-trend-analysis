create table Health(Country varchar (50),LifeExpectancy float,FertilityRate float,
	Population varchar(20),Region varchar(50));
select *
from health;

select distinct Country, lifeexpectancy, fertilityrate, population,region
from health
	order by country;

--updating the table
create table health_cleaned as
select distinct Country, lifeexpectancy, fertilityrate, population,region
from health
	order by country;

drop table health;             

alter table health_cleaned 
rename to health;         

select *
from health;

update health
set population= replace (population, ',', '');

alter table health
alter column population TYPE INTEGER using population::integer;
 
select *
from health;

select count(*)
from health 
where population is null;

select count(*)
from health 
where region is null;

select count(*)
from health 
where lifeexpectancy is null;

select count(*)
from health 
where fertilityraTE is null;

select  count( distinct region) as number_of_regions
from health;

-- The least populated countries
select country, population
from health
order by population asc
limit 10;

-- Most populated countries
select country, round(population, 2)
from health
order by population DESC
limit 10;


--total population by region 
select region, sum(population) as total_population
from health 
group by region;

--average population by region
select region, avg(population) as average_population
from health 
group by region
order by average_population;

-- Countries with highest life expectancies
 select country, lifeexpectancy
from health
order by lifeexpectancy desc
limit 10;

-- countries with lowest life expectancies
select country, lifeexpectancy
from health
order by lifeexpectancy asc
limit 10;


--average life expectancy by region
 select region, avg(lifeexpectancy) as AVG_life_expectancy
from health
group by  region
order by AVG_life_expectancy desc;


-- Highest and lowest fertility rate
 select country, fertilityrate
from health
order by fertilityrate desc
limit 10;

 select country, fertilityrate
from health
order by fertilityrate asc
limit 10;

--average fertility rate by region
           select region, avg(fertilityrate) as average_fertility_rate
from health 
group by region;


-- Correlation between Life expectancy and Fertility Rate
select country, lifeexpectancy, fertilityrate
from health
order by lifeexpectancy desc;

--Comparison of metrics across regions
select
region, 
round(avg( population),2) as avg_population,
avg(lifeexpectancy) as avg_lifeexpectancy,
avg(fertilityrate) as avg_fertilityrate
from health
	group by region;

-- countries with high population and low expectancy rate
select country, population, lifeexpectancy
from health
where population > ( select avg(population) from health) and lifeexpectancy 
< (select avg(lifeexpectancy) from health );

--Countries in specific region
select country, population, lifeexpectancy, fertilityrate
from health
where region = 'Sub-Saharan Africa'
order by population desc;
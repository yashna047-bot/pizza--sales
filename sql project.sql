
create database sql_project1;
use sql_project1;
create table order_details(
order_details_id int,
order_id  int,
pizza_id varchar(50),
quantity int
);

create table orders(
order_id  int,	
date	date,
time    time
);

create table pizzas(
pizza_id   varchar(90),
pizza_type_id	varchar(100),
size	varchar(10),
price  int
);

create table pizza_types(
pizza_type_id	varchar(100),
name	        varchar(100),
category		varchar(100),
ingredients		varchar(100)
);
use sql_project1;
select* from pizzas;
select * from pizza_types;
select* from orders;
select * from order_details;


-- Pizza Sales Analysis 

-- *1. Retrieve the total number of orders placed.
select count(*)  as total_orders from order_details; 

-- 2. Calculate the total revenue generated from pizza sales. 
use sql_project1;

select SUM(price * quantity)as total_revenue from order_details join pizzas on
pizzas.pizza_id=order_details.pizza_id;

-- 3. Identify the highest-priced pizza. 

select distinct name,price from pizza_types join pizzas on
pizzas.pizza_type_id=pizza_types.pizza_type_id
order by price desc  ;


-- 4. Identify the most common pizza size ordered.

select size,count(*) as order_count  from  pizzas join pizza_types on
pizzas.pizza_type_id=pizza_types.pizza_type_id
group by size 
order by size desc ;



-- 5. List the top 5 most ordered pizza types along with their quantities.

 
select pizza_types.name ,sum(order_details.quantity) as total_quantity from order_details join pizzas on 
pizzas.pizza_id=order_details.pizza_id join pizza_types on
pizzas.pizza_type_id=pizza_types.pizza_type_id
group by pizza_types.name
order by total_quantity desc limit 5;

-- 6. Join the necessary tables to find the total quantity of each pizza category ordered. 
select pizza_types.category as pizza_category ,sum(order_details.quantity) as total_quantity  from pizza_types join pizzas on 
pizzas.pizza_type_id=pizza_types.pizza_type_id join order_details on
order_details.pizza_id=pizzas.pizza_id
group by category ;


-- 7. Determine the distribution of orders by hour of the day. 
select  hour(time) as hours ,count(*) as total_orders from orders
group by hour(time)
order by hours;




-- 8. Join relevant tables to find the category-wise distribution of pizzas. 

select pizza_types.category as pizza_category,count(*) as pizzas  from pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category;


-- 9. Group the orders by date and calculate the average number of pizzas ordered per day. 
select date,sum(quantity) as pizzas_orderd from order_details 
join orders on 
orders.order_id=order_details.order_id
group by date
order by date;


-- 10. Determine the top 3 most ordered pizza types based on revenue.
select  name ,sum(price*quantity) as revenue from pizza_types join pizzas on 
pizzas.pizza_type_id=pizza_types.pizza_type_id join order_details on
order_details.pizza_id=pizzas.pizza_id
group by name
order by revenue desc limit 3;




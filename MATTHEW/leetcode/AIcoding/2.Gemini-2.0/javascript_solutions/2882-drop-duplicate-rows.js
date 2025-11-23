delete from Person
where Id not in (
    select minId from (
        select min(Id) as minId
        from Person
        group by Email
    ) as t
);
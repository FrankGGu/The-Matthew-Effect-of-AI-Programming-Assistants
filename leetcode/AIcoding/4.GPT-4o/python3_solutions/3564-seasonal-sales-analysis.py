SELECT 
    season, 
    SUM(sales) AS total_sales 
FROM 
    sales 
GROUP BY 
    season 
ORDER BY 
    FIELD(season, 'Spring', 'Summer', 'Fall', 'Winter');
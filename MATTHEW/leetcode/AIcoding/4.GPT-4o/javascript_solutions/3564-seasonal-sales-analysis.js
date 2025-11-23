SELECT 
    season, 
    SUM(sales) AS total_sales
FROM 
    Sales 
GROUP BY 
    season
ORDER BY 
    FIELD(season, 'Winter', 'Spring', 'Summer', 'Autumn');
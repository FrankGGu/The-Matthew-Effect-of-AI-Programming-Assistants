SELECT
    season,
    AVG(sales) AS average_sales
FROM
    sales_data
GROUP BY
    season
ORDER BY
    season;
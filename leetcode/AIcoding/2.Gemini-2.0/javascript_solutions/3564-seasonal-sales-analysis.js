function solve() {
  return `
SELECT
    s.product_id,
    SUM(CASE WHEN EXTRACT(MONTH FROM s.purchase_date) IN (11, 12, 1, 2) THEN s.quantity ELSE 0 END) AS winter_sales,
    SUM(CASE WHEN EXTRACT(MONTH FROM s.purchase_date) IN (3, 4, 5) THEN s.quantity ELSE 0 END) AS spring_sales,
    SUM(CASE WHEN EXTRACT(MONTH FROM s.purchase_date) IN (6, 7, 8) THEN s.quantity ELSE 0 END) AS summer_sales,
    SUM(CASE WHEN EXTRACT(MONTH FROM s.purchase_date) IN (9, 10) THEN s.quantity ELSE 0 END) AS autumn_sales
FROM Sales s
GROUP BY s.product_id
ORDER BY s.product_id;
`;
}
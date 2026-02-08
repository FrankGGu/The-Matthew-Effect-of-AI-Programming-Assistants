-module(solution).
-export([seasonal_sales_analysis/0]).

seasonal_sales_analysis() ->
  Query = "SELECT\n    s.product_id,\n    SUM(s.quantity) AS total_quantity\nFROM\n    Sales s\nJOIN\n    Product p ON s.product_id = p.product_id\nWHERE\n    s.sale_date BETWEEN '2000-01-01' AND '2000-12-31'\nGROUP BY\n    s.product_id\nHAVING\n    SUM(s.quantity) > 0\nORDER BY\n    s.product_id;",
  Query.
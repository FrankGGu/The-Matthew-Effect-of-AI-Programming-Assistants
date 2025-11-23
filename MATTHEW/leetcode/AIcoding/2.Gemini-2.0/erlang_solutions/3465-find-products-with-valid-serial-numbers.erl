-module(find_products_with_valid_serial_numbers).
-export([solve/0]).

solve() ->
    Query = "SELECT p.product_name FROM Products p INNER JOIN Valid_Serial s ON p.product_id = s.product_id;",

    % Dummy implementation for LeetCode.  Replace with actual DB query.

    io:format("~s~n", [Query]).  % Print the query for debugging

    % Simulate a result set (replace with actual DB result handling)
    Result = [
        {product_name, "S001"},
        {product_name, "S002"}
    ],

    ProductNameList = [ProductName || {product_name, ProductName} <- Result],

    lists:foreach(fun(ProductName) -> io:format("~s~n", [ProductName]) end, ProductNameList),

    ok.
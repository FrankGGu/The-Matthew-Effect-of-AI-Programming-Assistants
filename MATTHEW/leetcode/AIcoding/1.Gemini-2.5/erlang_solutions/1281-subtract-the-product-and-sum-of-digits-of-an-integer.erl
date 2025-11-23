-module(solution).
-export([subtract_product_and_sum/1]).

subtract_product_and_sum(N) ->
    subtract_product_and_sum_helper(N, 1, 0).

subtract_product_and_sum_helper(0, Product, Sum) ->
    Product - Sum;
subtract_product_and_sum_helper(N, Product, Sum) when N > 0 ->
    Digit = N rem 10,
    NewProduct = Product * Digit,
    NewSum = Sum + Digit,
    NewN = N div 10,
    subtract_product_and_sum_helper(NewN, NewProduct, NewSum).
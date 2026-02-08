-module(subtract_product_and_sum).
-export([subtract_product_and_sum/1]).

subtract_product_and_sum(N) ->
    Digits = integer_to_list(N),
    Product = lists:foldl(fun(D, Acc) -> Acc * (D - $0) end, 1, Digits),
    Sum = lists:foldl(fun(D, Acc) -> Acc + (D - $0) end, 0, Digits),
    Product - Sum.
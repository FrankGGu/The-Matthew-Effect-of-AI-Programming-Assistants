-module(max_product_of_three).
-export([maximum_product/1]).

maximum_product(Nums) ->
    Sorted = lists:sort(Nums),
    Length = length(Sorted),
    LastThree = lists:sublist(Sorted, Length - 2, 3),
    FirstTwo = lists:sublist(Sorted, 2),
    Product1 = lists:foldl(fun(X, Acc) -> X * Acc end, 1, LastThree),
    Product2 = lists:foldl(fun(X, Acc) -> X * Acc end, 1, FirstTwo) * lists:last(Sorted),
    max(Product1, Product2).
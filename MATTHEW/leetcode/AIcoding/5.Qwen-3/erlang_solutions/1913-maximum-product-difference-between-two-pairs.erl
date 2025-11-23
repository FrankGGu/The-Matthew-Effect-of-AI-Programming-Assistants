-module(max_product_difference).
-export([maxProductDifference/1]).

maxProductDifference(Numbers) ->
    Sorted = lists:sort(Numbers),
    [A, B | _] = Sorted,
    [_, _, _, C, D] = lists:reverse(Sorted),
    (D * C) - (B * A).
-module(max_product).
-export([max_product/1]).

max_product(Nums) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    A = lists:nth(Len - 1, Sorted),
    B = lists:nth(Len - 2, Sorted),
    (A - 1) * (B - 1).
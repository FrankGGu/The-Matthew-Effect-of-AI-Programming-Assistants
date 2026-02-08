-module(solution).
-export([max_product/2]).

max_product(Nums, K) ->
    max_product_helper(Nums, K, 0, 0).

max_product_helper([], K, _, Max) ->
    Max;
max_product_helper([H | T], K, Sum, Max) ->
    NewSum = Sum + H,
    NewMax = if NewSum == K -> max(H, Max); true -> Max end,
    max_product_helper(T, K, NewSum, NewMax),
    max_product_helper(T, K, Sum, Max).
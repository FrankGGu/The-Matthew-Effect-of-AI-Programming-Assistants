-module(maximum_product_difference).
-export([maxProductDifference/1]).

maxProductDifference(Nums) ->
  lists:sort(Nums, fun(A, B) -> A < B end) ->
  [A, B | Rest] = lists:sort(Nums),
  [_, _, _, D] = lists:reverse(lists:sort(Nums)),
  C = lists:nth(length(Nums) - 1, lists:sort(Nums)),
  D * C - A * B.
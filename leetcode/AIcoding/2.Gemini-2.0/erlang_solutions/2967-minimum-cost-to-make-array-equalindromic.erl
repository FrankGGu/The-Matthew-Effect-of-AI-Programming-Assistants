-module(minimum_cost_equalindromic).
-export([min_cost/1]).

min_cost(Nums) ->
  SortedNums = lists:sort(Nums),
  Median = lists:nth(length(SortedNums) div 2 + 1, SortedNums),
  Cost = lists:foldl(fun(Num, Acc) -> Acc + abs(Num - Median) end, 0, Nums),
  Cost.
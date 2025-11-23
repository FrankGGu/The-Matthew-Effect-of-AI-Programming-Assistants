-module(minimum_cost).
-export([min_cost/1]).

min_cost(Nums) ->
  min_cost(Nums, lists:sort(Nums), 0).

min_cost(Nums, Sorted, Cost) ->
  Len = length(Nums),
  Median = lists:nth(Len div 2 + 1, Sorted),
  calculate_cost(Nums, Median, 0).

calculate_cost([], _Median, Acc) ->
  Acc;
calculate_cost([H|T], Median, Acc) ->
  calculate_cost(T, Median, Acc + abs(H - Median)).
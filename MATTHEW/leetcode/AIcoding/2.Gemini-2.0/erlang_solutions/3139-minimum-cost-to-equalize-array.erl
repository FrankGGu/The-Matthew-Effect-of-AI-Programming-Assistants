-module(minimum_cost_equalize_array).
-export([min_cost/1]).

min_cost(Nums) ->
  min_cost(Nums, median(Nums)).

min_cost(Nums, Target) ->
  lists:sum([abs(Num - Target) || Num <- Nums]).

median(Nums) ->
  Sorted = lists:sort(Nums),
  Len = length(Sorted),
  case Len rem 2 of
    0 ->
      (lists:nth(Len div 2, Sorted) + lists:nth((Len div 2) + 1, Sorted)) div 2;
    1 ->
      lists:nth((Len + 1) div 2, Sorted)
  end.
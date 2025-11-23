-module(minimize_max_adjacent_diff).
-export([minimize_maximum_adjacent_difference/1]).

minimize_maximum_adjacent_difference(Nums) ->
  N = length(Nums),
  lists:foldl(
    fun(Num, Acc) ->
      Acc + (Num - Acc + 1) div 2
    end,
    lists:nth(1, Nums),
    tl(Nums)
  ).
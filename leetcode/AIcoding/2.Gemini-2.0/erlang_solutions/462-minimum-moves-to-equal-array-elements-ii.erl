-module(minimum_moves_to_equal_array_elements_ii).
-export([min_moves2/1]).

min_moves2(Nums) ->
  SortedNums = lists:sort(Nums),
  Median = lists:nth(length(SortedNums) div 2 + 1, SortedNums),
  min_moves2_helper(SortedNums, Median, 0).

min_moves2_helper([], _Median, Acc) ->
  Acc;
min_moves2_helper([H|T], Median, Acc) ->
  Diff = abs(H - Median),
  min_moves2_helper(T, Median, Acc + Diff).
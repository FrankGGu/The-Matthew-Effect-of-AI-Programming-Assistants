-module(sum_variable_length_subarrays).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, []).

solve([], Acc) ->
  lists:sum(Acc);
solve(Nums, Acc) ->
  Len = length(Nums),
  solve(Nums, Acc, 1, Len).

solve(_, Acc, Len, 0) ->
  lists:sum(Acc);
solve(Nums, Acc, Len, Remaining) ->
  SubArray = lists:sublist(Nums, Len),
  solve(Nums, [lists:sum(SubArray) | Acc], Len, Remaining - 1).
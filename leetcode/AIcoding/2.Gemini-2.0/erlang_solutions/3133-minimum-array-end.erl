-module(minimum_array_end).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, length(Nums)).

solve(Nums, K) ->
  case K of
    0 -> -1;
    _ ->
      solve_helper(Nums, K, 0, element(1, lists:min([ {get_val(Nums, I, K), I} || I <- lists:seq(0, K-1) ]))).

solve_helper(Nums, K, Count, MinIndex) ->
  case Count of
    K -> get_val(Nums, MinIndex, K);
    _ ->
      NewNums = rotate(Nums, K, MinIndex),
      NewMinIndex = element(1, lists:min([ {get_val(NewNums, I, K), I} || I <- lists:seq(0, K-1) ])),
      solve_helper(NewNums, K, Count + 1, NewMinIndex)
  end.

rotate(Nums, K, MinIndex) ->
  lists:sublist(lists:nthtail(MinIndex, Nums), K) ++ lists:sublist(Nums, MinIndex).

get_val(Nums, Index, K) ->
  lists:sum(lists:sublist(lists:nthtail(Index, Nums), K)).
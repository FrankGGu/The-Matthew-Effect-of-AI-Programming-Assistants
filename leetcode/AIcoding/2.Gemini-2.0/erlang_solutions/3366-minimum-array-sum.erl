-module(minimum_array_sum).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, 0, 0).

solve([], Acc, MinSum) ->
  case Acc > 0 of
    true ->
      min(MinSum, Acc);
    false ->
      MinSum
  end;
solve([H|T], Acc, MinSum) ->
  case Acc + H > 0 of
    true ->
      solve(T, Acc + H, min(MinSum, Acc + H));
    false ->
      solve(T, 0, MinSum)
  end.
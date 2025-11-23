-module(solution).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, 0).

solve([], Acc) ->
  Acc;
solve([_|[]], Acc) ->
  Acc;
solve([A, B | Rest], Acc) ->
  NewAcc = case A =< B of
             true -> Acc + 1;
             false -> Acc
           end,
  solve([B | Rest], NewAcc).
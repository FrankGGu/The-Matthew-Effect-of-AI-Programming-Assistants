-module(concatenated_divisibility).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, 0, 1).

solve([], Acc, Divisor) ->
  Acc rem Divisor == 0;
solve([H|T], Acc, Divisor) ->
  Len = length(integer_to_list(H)),
  NewAcc = Acc * (math:pow(10, Len)) + H,
  solve(T, NewAcc, Divisor).
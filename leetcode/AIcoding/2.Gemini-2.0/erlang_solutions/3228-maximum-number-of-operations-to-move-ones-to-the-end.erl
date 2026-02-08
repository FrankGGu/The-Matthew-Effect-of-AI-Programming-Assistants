-module(maximum_number_of_operations_to_move_ones_to_the_end).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, 0, 0).

solve([], Ones, Result) ->
  Result;
solve([0|Rest], Ones, Result) ->
  solve(Rest, Ones, Result + Ones);
solve([1|Rest], Ones, Result) ->
  solve(Rest, Ones + 1, Result).
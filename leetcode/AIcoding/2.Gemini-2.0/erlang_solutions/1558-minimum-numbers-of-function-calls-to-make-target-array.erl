-module(minimum_function_calls).
-export([min_operations/1]).

min_operations(Nums) ->
  min_operations(Nums, 0, 0).

min_operations([], Ones, Shifts) ->
  Ones + Shifts;
min_operations([0 | T], Ones, Shifts) ->
  min_operations(T, Ones, Shifts);
min_operations([N | T], Ones, Shifts) ->
  case N rem 2 of
    0 ->
      min_operations([N div 2 | T], Ones, Shifts + 1);
    1 ->
      min_operations([N div 2 | T], Ones + 1, Shifts + 1)
  end.
-module(find_positive_integer_solution).
-export([find_solution/2]).

find_solution(CustomFunction, Z) ->
  find_solutions(CustomFunction, Z, 1, 1, []).

find_solutions(CustomFunction, Z, X, Y, Acc) when X > 1000 orelse Y < 1 ->
  lists:reverse(Acc);
find_solutions(CustomFunction, Z, X, Y, Acc) ->
  Val = CustomFunction(X, Y),
  case Val of
    Z ->
      find_solutions(CustomFunction, Z, X + 1, 1, [[X, Y] | Acc]);
    Val when Val < Z ->
      find_solutions(CustomFunction, Z, X + 1, Y, Acc);
    _ ->
      find_solutions(CustomFunction, Z, X, Y - 1, Acc)
  end.
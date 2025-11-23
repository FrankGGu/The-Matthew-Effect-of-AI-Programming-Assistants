-module(eat_pizzas).
-export([solve/1]).

solve(pizzas) ->
  solve(pizzas, 0, 0).

solve([], Count, _) ->
  Count;
solve([Pizza | Rest], Count, LastSize) ->
  case Pizza >= LastSize of
    true ->
      solve(Rest, Count + 1, Pizza);
    false ->
      solve(Rest, Count, LastSize)
  end.
-module(reverse_degree).
-export([solve/1]).

solve(S) ->
  solve(S, 0).

solve([], Acc) ->
  Acc;
solve([H|T], Acc) ->
  solve(T, Acc + (H - $a + 1)).
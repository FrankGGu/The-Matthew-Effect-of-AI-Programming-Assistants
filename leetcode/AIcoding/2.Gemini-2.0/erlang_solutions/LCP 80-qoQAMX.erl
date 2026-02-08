-module(solution).
-export([solve/1]).

solve(N) ->
  solve(N, 0, 1).

solve(0, Count, _) ->
  Count;
solve(N, Count, Generation) ->
  NextGeneration = 3 * Generation,
  if
    NextGeneration > N ->
      Count;
    true ->
      solve(N, Count + 1, NextGeneration)
  end.
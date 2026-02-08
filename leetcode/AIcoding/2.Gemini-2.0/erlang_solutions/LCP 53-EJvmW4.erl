-module(solve).
-export([solve/1]).

solve(demands) ->
  solve(demands, 0, 0).

solve([], _, Cost) ->
  Cost;
solve([{Day, Count} | Rest], LastDay, CostSoFar) ->
  case Day > LastDay of
    true ->
      solve(Rest, Day + 1, CostSoFar + Count);
    false ->
      solve(Rest, LastDay + 1, CostSoFar + Count)
  end.
-module(min_cost).
-export([solve/1]).

solve(Diffs) ->
  SortedDiffs = lists:sort(Diffs),
  N = length(SortedDiffs),
  Median = lists:nth(N div 2 + 1, SortedDiffs),
  lists:foldl(fun(X, Acc) -> Acc + abs(X - Median) end, 0, SortedDiffs).
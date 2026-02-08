-module(max_groups).
-export([solve/1]).

solve(Groups) ->
  lists:sort(Groups) -> SortedGroups,
  solve_helper(SortedGroups, 0, 0).

solve_helper([], Count, _) ->
  Count;
solve_helper([H|T], Count, PrevSum) ->
  if
    PrevSum + 1 =< H ->
      solve_helper(T, Count + 1, PrevSum + 1);
    true ->
      solve_helper(T, Count, PrevSum)
  end.
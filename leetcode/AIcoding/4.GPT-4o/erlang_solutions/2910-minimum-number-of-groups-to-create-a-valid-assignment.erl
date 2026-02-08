-module(solution).
-export([min_groups/1]).

min_groups(Assignments) ->
    AssignmentsSorted = lists:sort(Assignments),
    min_groups_helper(AssignmentsSorted, 0, 0).

min_groups_helper([], Count, _) ->
    Count;
min_groups_helper([H | T], Count, Prev) when H > Prev ->
    min_groups_helper(T, Count + 1, H);
min_groups_helper([H | T], Count, Prev) ->
    min_groups_helper(T, Count, Prev).
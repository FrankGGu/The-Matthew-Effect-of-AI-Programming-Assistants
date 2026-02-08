-module(max_tasks).
-export([max_tasks/2]).

max_tasks(Tasks, Assignments) ->
    Max = length(Tasks),
    SortedTasks = lists:sort(Tasks),
    SortedAssignments = lists:sort(Assignments),
    N = length(SortedTasks),
    M = length(SortedAssignments),
    Result = 0,
    do_max_tasks(SortedTasks, SortedAssignments, N, M, Result).

do_max_tasks(_, _, 0, _, Acc) -> Acc;
do_max_tasks(_, [], _, _, Acc) -> Acc;
do_max_times([], _, _, _, Acc) -> Acc;
do_max_tasks(Tasks, Assignments, N, M, Acc) ->
    {Task, RestTasks} = lists:split(1, Tasks),
    [T] = Task,
    case find_first_ge(Assignments, T) of
        none -> Acc;
        Index ->
            NewAcc = Acc + 1,
            NewAssignments = lists:sublist(Assignments, Index) ++ lists:sublist(Assignments, Index+1, M - Index),
            do_max_tasks(RestTasks, NewAssignments, N-1, M-1, NewAcc)
    end.

find_first_ge(List, X) ->
    find_first_ge(List, X, 1).

find_first_ge([], _, _) -> none;
find_first_ge([H | T], X, Index) when H >= X -> Index;
find_first_ge([_ | T], X, Index) -> find_first_ge(T, X, Index + 1).
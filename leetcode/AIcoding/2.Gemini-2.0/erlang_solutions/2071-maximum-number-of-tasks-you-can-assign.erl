-module(maximum_tasks).
-export([max_tasks/2]).

max_tasks(tasks, workers) ->
    SortedTasks = lists:sort(tasks),
    SortedWorkers = lists:sort(workers),
    max_tasks_helper(SortedTasks, SortedWorkers, 0).

max_tasks_helper([], _, Count) ->
    Count;
max_tasks_helper(_, [], Count) ->
    Count;
max_tasks_helper(Tasks, Workers, Count) ->
    case can_assign(Tasks, Workers) of
        {true, NewTasks, NewWorkers} ->
            max_tasks_helper(NewTasks, NewWorkers, Count + 1);
        false ->
            Count
    end.

can_assign([Task | RestTasks], [Worker | RestWorkers]) ->
    if
        Task =< Worker ->
            {true, RestTasks, RestWorkers};
        true ->
            false
    end.
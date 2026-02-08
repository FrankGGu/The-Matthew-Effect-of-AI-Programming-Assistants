-module(process_tasks_using_servers).
-export([assign_tasks/2]).

assign_tasks(Workers, Tasks) ->
    WorkersList = lists:sort(Workers),
    TaskQueue = lists:seq(0, length(Tasks) - 1),
    assign_tasks(WorkersList, Tasks, TaskQueue, 0, []).

assign_tasks(_, _, [], _, Result) ->
    Result;
assign_tasks(Workers, Tasks, [TaskIndex | RestTaskQueue], Time, Result) ->
    {WorkerIndex, WorkerTime} = pick_worker(Workers, Time),
    NewWorkers = lists:sublist(Workers, WorkerIndex) ++ [{WorkerIndex, WorkerTime + element(TaskIndex + 1, Tasks)}] ++ lists:nthtail(WorkerIndex + 1, Workers),
    assign_tasks(NewWorkers, Tasks, RestTaskQueue, Time + 1, [WorkerIndex | Result]).

pick_worker([], _) ->
    {0, 0};
pick_worker([{Index, Time} | Rest], CurrentTime) ->
    case Time < CurrentTime of
        true ->
            {Index, Time};
        false ->
            pick_worker(Rest, CurrentTime)
    end.
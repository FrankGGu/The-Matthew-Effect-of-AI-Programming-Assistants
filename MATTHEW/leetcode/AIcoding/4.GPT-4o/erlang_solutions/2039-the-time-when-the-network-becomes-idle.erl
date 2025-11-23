-module(solution).
-export([networkBecomesIdle/2]).

networkBecomesIdle(servers, tasks) ->
    TaskTime = lists:map(fun({_, t}) -> t end, tasks),
    MaxTaskTime = lists:max(TaskTime),
    ServerCount = length(servers),
    TotalTasks = length(tasks),
    IdleTime = (TotalTasks div ServerCount) * MaxTaskTime,
    if TotalTasks rem ServerCount > 0 ->
        IdleTime + MaxTaskTime;
    true ->
        IdleTime
    end.
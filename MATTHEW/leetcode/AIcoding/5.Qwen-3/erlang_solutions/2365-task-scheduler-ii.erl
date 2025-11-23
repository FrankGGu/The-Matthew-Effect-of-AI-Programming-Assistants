-module(task_scheduler_ii).
-export([least_interval/2]).

least_interval(RemainingTasks, n) ->
    TaskCounts = lists:foldl(fun(Task, Acc) -> dict:update_counter(Task, 1, Acc) end, dict:new(), RemainingTasks),
    Counts = dict:values(TaskCounts),
    MaxCount = lists:max(Counts),
    NumMax = lists:foldl(fun(C, Acc) -> if C == MaxCount -> Acc + 1; true -> Acc end end, 0, Counts),
    (MaxCount - 1) * (n + 1) + NumMax.
-module(solution).
-export([task_scheduler/2]).

task_scheduler(Task, N) ->
    Map = lists:foldl(fun(T, Acc) -> maps:update(T, maps:get(T, Acc, 0) + 1, Acc) end, #{}, Task),
    MaxCount = lists:max(maps:values(Map)),
    CountMax = lists:foldl(fun(V, Acc) -> if V == MaxCount -> Acc + 1; true -> Acc end end, 0, maps:values(Map)),
    (MaxCount - 1) * (N + 1) + CountMax.
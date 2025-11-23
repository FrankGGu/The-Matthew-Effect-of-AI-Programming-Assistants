-module(task_scheduler).
-export([least_interval/2]).

least_interval(R, N) ->
    Count = lists:foldl(fun(E, Acc) -> maps:update_with(E, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), R),
    Max = lists:max(maps:values(Count)),
    NumMax = lists:foldl(fun(V, Acc) -> if V == Max -> Acc + 1; true -> Acc end end, 0, maps:values(Count)),
    (Max - 1) * (N + 1) + NumMax.
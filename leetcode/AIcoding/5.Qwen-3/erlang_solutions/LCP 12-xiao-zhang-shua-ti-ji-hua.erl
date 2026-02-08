-module(solution).
-export([least_interval/2]).

least_interval(Tasks, N) ->
    Count = lists:foldl(fun(Task, Acc) -> 
        maps:update_with(Task, fun(V) -> V + 1 end, 1, Acc) 
    end, maps:new(), Tasks),
    Max = lists:max(maps:values(Count)),
    NumMax = maps:fold(fun(_K, V, Acc) -> if V == Max -> Acc + 1; true -> Acc end end, 0, Count),
    (Max - 1) * (N + 1) + NumMax.
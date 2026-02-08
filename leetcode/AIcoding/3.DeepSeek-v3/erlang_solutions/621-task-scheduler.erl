-module(task_scheduler).
-export([least_interval/2]).

least_interval(Tasks, N) ->
    FreqMap = lists:foldl(fun(Task, Map) ->
        maps:update_with(Task, fun(V) -> V + 1 end, 1, Map)
    end, #{}, Tasks),
    Freqs = maps:values(FreqMap),
    MaxFreq = lists:max(Freqs),
    MaxCount = length([F || F <- Freqs, F == MaxFreq]),
    max(length(Tasks), (MaxFreq - 1) * (N + 1) + MaxCount).
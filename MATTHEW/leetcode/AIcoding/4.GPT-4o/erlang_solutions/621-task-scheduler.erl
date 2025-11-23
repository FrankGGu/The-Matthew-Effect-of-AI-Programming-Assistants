-module(solution).
-export([leastInterval/2]).

leastInterval(TaskList, N) ->
    TaskCounts = maps:from_list(lists:map(fun(X) -> {X, 1} end, TaskList)),
    MaxCount = lists:max(maps:values(TaskCounts)),
    MaxCountOccurrences = length(lists:filter(fun(X) -> X == MaxCount end, maps:values(TaskCounts))),
    TotalSlots = (MaxCount - 1) * (N + 1) + MaxCountOccurrences,
    lists:max([length(TaskList), TotalSlots]).
-module(solution).
-export([min_processing_time/2]).

min_processing_time(ProcessorTime, Tasks) ->
    SortedProcessorTime = lists:sort(ProcessorTime),
    SortedTasks = lists:sort(fun(A, B) -> A >= B end, Tasks),
    lists:max([P + T || {P, T} <- lists:zip(SortedProcessorTime, lists:sublist(SortedTasks, length(SortedProcessorTime))]).
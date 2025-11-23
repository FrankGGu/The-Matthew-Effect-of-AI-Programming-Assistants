-module(minimum_processing_time).
-export([minProcessingTime/1]).

minProcessingTime(Queries) ->
    lists:sort(fun(A, B) -> A =< B end, Queries),
    lists:foldl(fun(T, Acc) -> max(T, Acc) end, 0, Queries).
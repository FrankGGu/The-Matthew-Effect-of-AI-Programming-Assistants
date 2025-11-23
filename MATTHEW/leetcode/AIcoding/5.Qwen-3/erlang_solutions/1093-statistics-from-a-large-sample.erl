-module(solution).
-export([statistics/1]).

statistics(Sample) ->
    Counts = lists:foldl(fun(X, Acc) -> dict:update_counter(X, 1, Acc) end, dict:new(), Sample),
    Keys = dict:keys(Counts),
    MaxFreq = lists:max([dict:fetch(K, Counts) || K <- Keys]),
    MostFrequent = [K || K <- Keys, dict:fetch(K, Counts) == MaxFreq],
    case length(MostFrequent) of
        1 -> {lists:sum(Sample), lists:sum([X*X || X <- Sample]), lists:median(Sample), hd(MostFrequent)};
        _ -> {lists:sum(Sample), lists:sum([X*X || X <- Sample]), lists:median(Sample), lists:hd(lists:sort(MostFrequent))}
    end.
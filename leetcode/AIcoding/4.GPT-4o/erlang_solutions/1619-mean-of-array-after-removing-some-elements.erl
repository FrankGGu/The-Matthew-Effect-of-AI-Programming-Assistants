-module(solution).
-export([trimMean/1]).

trimMean(Array) ->
    Sorted = lists:sort(Array),
    Len = length(Sorted),
    TrimmedLen = Len * 5 div 100,
    Trimmed = lists:sublist(Sorted, TrimmedLen + 1, Len - 2 * TrimmedLen),
    lists:sum(Trimmed) / length(Trimmed).
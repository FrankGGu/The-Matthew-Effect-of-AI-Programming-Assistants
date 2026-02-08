-module(solution).
-export([maxFrequency/2]).

maxFrequency(A, k) ->
    Sorted = lists:sort(A),
    MaxFreq = max_frequency(Sorted, k, length(Sorted)),
    MaxFreq.

max_frequency(Sorted, K, N) ->
    lists:foldl(fun(X, {Count, Max}) ->
        NewCount = Count + (if X == hd(Sorted) -> 1; true -> 0 end),
        NewMax = lists:max([Max, NewCount]),
        {NewCount, NewMax}
    end, {0, 0}, Sorted).
-module(solution).
-export([trim_mean/1]).

trim_mean(Arr) ->
    Len = length(Arr),
    K = trunc(Len * 0.05),
    SortedArr = lists:sort(Arr),
    TrimmedArr = lists:sublist(SortedArr, K + 1, Len - 2 * K),
    Sum = lists:sum(TrimmedArr),
    Count = length(TrimmedArr),
    Sum / Count.
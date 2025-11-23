-module(solution).
-export([minimum_difference/2]).

-spec minimum_difference(Nums :: [integer()], K :: integer()) -> integer().
minimum_difference(Nums, K) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),
    if K == 1 ->
        0;
    true ->
        Differences = [lists:nth(I + K - 1, SortedNums) - lists:nth(I, SortedNums)
                       || I <- lists:seq(1, Len - K + 1)],
        lists:min(Differences)
    end.
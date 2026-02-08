-module(range_sum_sorted_subarray_sums).
-export([range_sum/3]).

range_sum(Nums, N, Left, Right) ->
    SubarraySums = lists:flatten([
        [lists:sum(lists:sublist(Nums, I, Len)) || Len <- lists:seq(1, N - I + 1)]
        || I <- lists:seq(1, N)
    ]),
    SortedSums = lists:sort(SubarraySums),
    Length = length(SortedSums),
    Mod = 1000000007,
    Sum = lists:foldl(fun(Index, Acc) ->
        (Acc + lists:nth(Index, SortedSums)) rem Mod
    end, 0, lists:seq(Left, Right)),
    Sum rem Mod.
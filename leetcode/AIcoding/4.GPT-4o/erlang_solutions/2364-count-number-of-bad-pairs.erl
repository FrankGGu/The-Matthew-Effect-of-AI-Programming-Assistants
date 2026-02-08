-module(solution).
-export([count_bad_pairs/1]).

count_bad_pairs(Array) ->
    N = length(Array),
    Pairs = N * (N - 1) div 2,
    GoodPairs = lists:foldl(fun({Idx, Val}, Acc) ->
        GoodCount = Acc + (Idx - Val)
    end, 0, lists:zip(lists:seq(0, N - 1), Array)),
    Pairs - GoodPairs.
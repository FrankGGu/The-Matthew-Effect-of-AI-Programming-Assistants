-module(solution).
-export([countBadPairs/1]).

-spec countBadPairs(Nums :: [integer()]) -> integer().
countBadPairs(Nums) ->
    N = length(Nums),
    TotalPairs = N * (N - 1) div 2,

    FreqMap = build_freq_map(Nums, 0, #{}),

    GoodPairsCount = calculate_good_pairs(FreqMap),

    TotalPairs - GoodPairsCount.

build_freq_map([], _I, FreqMap) ->
    FreqMap;
build_freq_map([H|T], I, FreqMap) ->
    Value = H - I,
    Count = maps:get(Value, FreqMap, 0),
    NewFreqMap = maps:put(Value, Count + 1, FreqMap),
    build_freq_map(T, I + 1, NewFreqMap).

calculate_good_pairs(FreqMap) ->
    lists:foldl(fun(Count, Acc) ->
                    Acc + (Count * (Count - 1) div 2)
                end, 0, maps:values(FreqMap)).
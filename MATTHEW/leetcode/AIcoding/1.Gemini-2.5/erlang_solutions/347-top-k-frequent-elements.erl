-module(solution).
-export([top_k_frequent/2]).

top_k_frequent(Nums, K) ->
    FreqMap = lists:foldl(fun(Num, AccMap) ->
                              maps:update_with(Num, fun(Count) -> Count + 1 end, 1, AccMap)
                          end, maps:new(), Nums),

    SortedByCount = lists:sort(fun({CountA, _}, {CountB, _}) -> CountA >= CountB end,
                               lists:map(fun({Num, Count}) -> {Count, Num} end, maps:to_list(FreqMap))),

    TopKTuples = lists:sublist(SortedByCount, K),

    lists:map(fun({_, Num}) -> Num end, TopKTuples).
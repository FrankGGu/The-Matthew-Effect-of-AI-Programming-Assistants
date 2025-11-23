-module(solution).
-export([top_k_frequent/2]).

top_k_frequent(Nums, K) ->
    FreqMap = lists:foldl(fun(Num, AccMap) ->
                                  maps:update_with(Num, fun(Count) -> Count + 1 end, 1, AccMap)
                          end, maps:new(), Nums),

    FreqList = lists:map(fun({Element, Frequency}) -> {Frequency, Element} end, maps:to_list(FreqMap)),

    SortedFreqList = lists:sort(fun({FreqA, _}, {FreqB, _}) -> FreqA >= FreqB end, FreqList),

    TopKTuples = lists:sublist(SortedFreqList, K),

    lists:map(fun({_, Element}) -> Element end, TopKTuples).
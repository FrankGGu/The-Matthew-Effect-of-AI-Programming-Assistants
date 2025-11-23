-module(solution).
-export([topKFrequent/2]).

topKFrequent(Words, K) ->
    FreqMap = lists:foldl(fun(Word, AccMap) ->
                                  maps:update_with(Word, fun(Count) -> Count + 1 end, 1, AccMap)
                          end, #{}, Words),

    FreqList = maps:fold(fun(Word, Freq, Acc) ->
                                 [{Freq, Word} | Acc]
                         end, [], FreqMap),

    SortedFreqList = lists:sort(fun({F1, W1}, {F2, W2}) ->
                                        F1 > F2 orelse (F1 == F2 andalso W1 < W2)
                                end, FreqList),

    TopKTuples = lists:sublist(SortedFreqList, K),
    lists:map(fun({_Freq, Word}) -> Word end, TopKTuples).
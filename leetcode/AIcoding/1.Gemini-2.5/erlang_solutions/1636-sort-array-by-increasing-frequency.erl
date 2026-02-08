-module(solution).
-export([frequency_sort/1]).

-spec frequency_sort(Nums :: [integer()]) -> [integer()].
frequency_sort(Nums) ->
    FreqMap = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(Count) -> Count + 1 end, 1, Acc) end, #{}, Nums),
    FreqValueList = maps:fold(fun(Value, Freq, Acc) -> [{Freq, Value} | Acc] end, [], FreqMap),
    SortedFreqValueList = lists:sort(fun({F1, V1}, {F2, V2}) ->
                                         if
                                             F1 == F2 -> V1 > V2;
                                             true -> F1 < F2
                                         end
                                     end, FreqValueList),
    lists:flatmap(fun({Freq, Value}) -> lists:duplicate(Freq, Value) end, SortedFreqValueList).
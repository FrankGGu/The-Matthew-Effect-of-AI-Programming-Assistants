-module(solution).
-export([max_number_of_pairs/1]).

max_number_of_pairs(Nums) ->
    FreqMap = lists:foldl(fun(N, AccMap) ->
                                    Count = maps:get(N, AccMap, 0),
                                    maps:put(N, Count + 1, AccMap)
                            end, #{}, Nums),

    {TotalPairs, TotalRemaining} = maps:fold(fun(_Key, Count, {AccPairs, AccRemaining}) ->
                                                    Pairs = Count div 2,
                                                    Remaining = Count rem 2,
                                                    {AccPairs + Pairs, AccRemaining + Remaining}
                                            end, {0, 0}, FreqMap),

    [TotalPairs, TotalRemaining].
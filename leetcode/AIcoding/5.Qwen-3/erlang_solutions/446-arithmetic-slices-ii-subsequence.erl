-module(arithmetic_slicessubsequence).
-export([number_of_arithmetic_slices/1]).

number_of_arithmetic_slices(Nums) ->
    N = length(Nums),
    if
        N < 3 -> 0;
        true ->
            Maps = lists:seq(0, N-1),
            DP = maps:new(),
            Total = 0,
            lists:foldl(fun(I, Acc) ->
                                lists:foldl(fun(J, Acc2) ->
                                                    if
                                                        J < I ->
                                                            Diff = lists:nth(I+1, Nums) - lists:nth(J+1, Nums),
                                                            Map = maps:get(J, DP, maps:new()),
                                                            Count = maps:get(Diff, Map, 0),
                                                            NewMap = maps:put(Diff, Count + 1, Map),
                                                            NewDP = maps:put(J, NewMap, DP),
                                                            Acc2 + Count;
                                                        true -> Acc2
                                                    end
                                            end, Acc, Maps)
                        end, 0, Maps)
    end.
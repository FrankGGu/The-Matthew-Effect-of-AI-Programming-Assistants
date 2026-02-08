-module(solution).
-export([max_freq/1]).

max_freq(Nums) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    MaxFreq = 0,
    Map = maps:new(),
    lists:foldl(fun(X, Acc) ->
        Count = maps:get(X, Acc, 0) + 1,
        maps:put(X, Count, Acc)
    end, Map, Sorted),
    Keys = maps:keys(Map),
    lists:foldl(fun(Key, Acc) ->
        Count = maps:get(Key, Map),
        if
            Count > Acc -> Count;
            true -> Acc
        end
    end, 0, Keys).
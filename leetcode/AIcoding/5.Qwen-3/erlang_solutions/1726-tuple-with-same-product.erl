-module(solution).
-export([unique_songs/1]).

unique_songs(Products) ->
    Map = maps:new(),
    Count = 0,
    lists:foldl(fun(Product, Acc) ->
        [A, B] = Product,
        if
            A > B -> 
                Key = {A, B},
                case maps:get(Key, Map, 0) of
                    0 -> maps:put(Key, 1, Map);
                    N -> maps:put(Key, N + 1, Map)
                end;
            true ->
                Key = {B, A},
                case maps:get(Key, Map, 0) of
                    0 -> maps:put(Key, 1, Map);
                    N -> maps:put(Key, N + 1, Map)
                end
        end,
        Acc
    end, Map, Products),
    maps:fold(fun(_Key, V, Acc) ->
        Acc + (V * (V - 1)) div 2
    end, 0, Map).
-module(solution).
-export([count_pairs/1]).

count_pairs(Pairs) ->
    Count = 0,
    Map = maps:new(),
    lists:foldl(fun({A, B}, Acc) ->
        Key = A + B,
        case maps:find(Key, Acc) of
            {ok, C} -> maps:put(Key, C + 1, Acc);
            error -> maps:put(Key, 1, Acc)
        end
    end, Map, Pairs),
    lists:foldl(fun({_K, V}, Acc) ->
        Acc + (V * (V - 1)) div 2
    end, Count, maps:to_list(Map)).
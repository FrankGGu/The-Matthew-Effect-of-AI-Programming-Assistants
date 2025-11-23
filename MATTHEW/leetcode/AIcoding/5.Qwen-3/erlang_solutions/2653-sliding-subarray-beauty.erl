-module(slide).
-export([mostFrequent/2]).

mostFrequent(Nums, K) ->
    Count = make_ref(),
    lists:foldl(fun(N, Acc) -> 
        case maps:is_key(N, Acc) of
            true -> maps:update(N, maps:get(N, Acc) + 1, Acc);
            false -> maps:put(N, 1, Acc)
        end
    end, maps:new(), Nums),
    lists:foldl(fun(I, {Acc, Map}) ->
        if I >= K ->
            Key = lists:nth(I - K + 1, Nums),
            NewMap = maps:update(Key, maps:get(Key, Map) - 1, Map),
            if maps:get(Key, NewMap) == 0 -> maps:remove(Key, NewMap);
               true -> NewMap
            end,
            {Acc ++ [lists:foldl(fun({K, V}, {MaxKey, MaxCount}) ->
                if V > MaxCount -> {K, V};
                   true -> {MaxKey, MaxCount}
                end
            end, {0, 0}, maps:to_list(NewMap))], NewMap};
           true ->
            {Acc, Map}
        end
    end, {[], maps:new()}, lists:seq(1, length(Nums))).

slide(Nums, K) ->
    mostFrequent(Nums, K).
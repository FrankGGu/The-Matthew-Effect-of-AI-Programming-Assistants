-spec array_change(Nums :: [integer()], Operations :: [[integer()]]) -> [integer()].
array_change(Nums, Operations) ->
    Map = maps:from_list(lists:zipwith(fun(Index, Value) -> {Value, Index} end, lists:seq(1, length(Nums)), Nums)),
    UpdatedMap = lists:foldl(fun([From, To], AccMap) ->
        case maps:find(From, AccMap) of
            {ok, Index} -> 
                maps:put(To, Index, maps:remove(From, AccMap));
            error -> 
                AccMap
        end
    end, Map, Operations),
    lists:foldl(fun({Value, Index}, Acc) ->
        lists:sublist(Acc, Index - 1) ++ [Value] ++ lists:nthtail(Index, Acc)
    end, Nums, maps:to_list(UpdatedMap)).
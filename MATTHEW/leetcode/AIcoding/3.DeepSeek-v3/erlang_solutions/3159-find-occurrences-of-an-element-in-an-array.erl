-spec find_occurrences(Items :: [integer()], Queries :: [integer()]) -> [[integer()]].
find_occurrences(Items, Queries) ->
    Map = lists:foldl(fun(Item, Acc) ->
        Index = length(Acc) + 1,
        case maps:get(Item, Acc, []) of
            L when is_list(L) -> maps:put(Item, L ++ [Index], Acc)
        end
    end, #{}, Items),
    lists:map(fun(Query) ->
        maps:get(Query, Map, [])
    end, Queries).
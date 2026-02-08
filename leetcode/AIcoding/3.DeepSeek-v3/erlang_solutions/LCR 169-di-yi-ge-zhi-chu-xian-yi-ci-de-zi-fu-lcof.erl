-spec dismantling_action(Arr :: unicode:unicode_binary()) -> integer().
dismantling_action(Arr) ->
    Map = maps:new(),
    lists:foldl(fun(Char, {Map, Max}) ->
        case maps:get(Char, Map, undefined) of
            undefined ->
                {maps:put(Char, 1, Map), Max};
            Count ->
                {maps:put(Char, Count + 1, Map), max(Max, Count + 1)}
        end
    end, {Map, 0}, Arr),
    element(2, lists:foldl(fun(Char, {Map, Max}) ->
        case maps:get(Char, Map, undefined) of
            1 ->
                {maps:remove(Char, Map), Max};
            Count ->
                {maps:put(Char, Count - 1, Map), Max}
        end
    end, {Map, 0}, Arr)).
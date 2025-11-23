-spec dismantling_action(Arr :: unicode:unicode_binary()) -> integer().
dismantling_action(Arr) ->
    Map = maps:new(),
    {_, _, Max} = binary:foldl(fun(Char, {Start, MapAcc, MaxLen}) ->
        case maps:find(Char, MapAcc) of
            {ok, Pos} when Pos >= Start ->
                {Pos + 1, maps:put(Char, Start, MapAcc), max(MaxLen, Start - Pos)};
            _ ->
                {Start, maps:put(Char, Start, MapAcc), max(MaxLen, Start - maps:get(Char, MapAcc, 0) + 1)}
        end
    end, {0, Map, 0}, Arr),
    Max.
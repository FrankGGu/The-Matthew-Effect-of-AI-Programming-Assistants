-spec shortest_to_char(S :: unicode:unicode_binary(), C :: char()) -> [integer()].
shortest_to_char(S, C) ->
    String = unicode:characters_to_list(S),
    N = length(String),
    Result = lists:duplicate(N, 0),
    Prev = -N,
    {Result1, _} = lists:foldl(fun(Char, {Res, PrevPos}) ->
        case Char =:= C of
            true -> {Res, 0};
            false -> {Res, PrevPos + 1}
        end
    end, {Result, Prev}, String),
    {Result2, _} = lists:foldr(fun(Char, {Res, PrevPos}) ->
        case Char =:= C of
            true -> {Res, 0};
            false -> 
                Min = min(PrevPos + 1, lists:nth(length(Res) - length(Res) + 1, Res)),
                {lists:sublist(Res, length(Res) - 1) ++ [Min], Min}
        end
    end, {Result1, Prev}, String),
    Result2.
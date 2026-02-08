-spec max_length_between_equal_characters(S :: unicode:unicode_binary()) -> integer().
max_length_between_equal_characters(S) ->
    Map = maps:new(),
    {Max, _} = binary:foldl(fun(Char, {CurrentMax, AccMap}) ->
        case maps:find(Char, AccMap) of
            {ok, Pos} -> {max(CurrentMax, Pos - 1), AccMap};
            error -> {CurrentMax, maps:put(Char, 1, AccMap)}
        end
    end, {-1, Map}, S),
    Max.
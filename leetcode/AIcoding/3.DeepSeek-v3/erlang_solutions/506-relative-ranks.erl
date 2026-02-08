-spec find_relative_ranks(Score :: [integer()]) -> [unicode:unicode_binary()].
find_relative_ranks(Score) ->
    Indexed = lists:zip(lists:seq(1, length(Score)), Score),
    Sorted = lists:reverse(lists:keysort(2, Indexed)),
    Ranks = lists:foldl(fun({Index, _}, {Pos, Acc}) ->
        case Pos of
            1 -> {Pos + 1, maps:put(Index, <<"Gold Medal">>, Acc)};
            2 -> {Pos + 1, maps:put(Index, <<"Silver Medal">>, Acc)};
            3 -> {Pos + 1, maps:put(Index, <<"Bronze Medal">>, Acc)};
            _ -> {Pos + 1, maps:put(Index, integer_to_binary(Pos), Acc)}
        end
    end, {1, maps:new()}, Sorted),
    {_, RankMap} = Ranks,
    [maps:get(I, RankMap) || I <- lists:seq(1, length(Score))].
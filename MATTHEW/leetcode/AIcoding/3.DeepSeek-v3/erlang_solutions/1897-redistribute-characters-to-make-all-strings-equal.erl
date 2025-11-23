-spec make_equal(Words :: [unicode:unicode_binary()]) -> boolean().
make_equal(Words) ->
    Counts = lists:foldl(fun(Word, Acc) ->
        lists:foldl(fun(Char, AccIn) ->
            maps:update_with(Char, fun(V) -> V + 1 end, 1, AccIn)
        end, Acc, unicode:characters_to_list(Word))
    end, #{}, Words),
    lists:all(fun({_, V}) -> V rem length(Words) =:= 0 end, maps:to_list(Counts)).
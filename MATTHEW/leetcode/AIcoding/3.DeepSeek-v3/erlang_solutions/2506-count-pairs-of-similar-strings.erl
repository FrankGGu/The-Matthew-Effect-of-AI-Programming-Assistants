-spec similar_pairs(Words :: [unicode:unicode_binary()]) -> integer().
similar_pairs(Words) ->
    CharSets = lists:map(fun(Word) ->
        lists:usort(binary_to_list(Word))
    end, Words),
    Counts = lists:foldl(fun(Chars, Acc) ->
        Key = lists:sort(Chars),
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, CharSets),
    lists:foldl(fun({_, V}, Sum) ->
        Sum + (V * (V - 1)) div 2
    end, 0, maps:to_list(Counts)).
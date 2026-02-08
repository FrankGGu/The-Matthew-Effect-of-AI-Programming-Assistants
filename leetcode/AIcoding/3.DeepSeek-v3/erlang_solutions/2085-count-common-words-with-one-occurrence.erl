-spec count_words(Words1 :: [unicode:unicode_binary()], Words2 :: [unicode:unicode_binary()]) -> integer().
count_words(Words1, Words2) ->
    Map1 = count_occurrences(Words1),
    Map2 = count_occurrences(Words2),
    lists:foldl(fun(Word, Acc) ->
                    case {maps:get(Word, Map1, 0), maps:get(Word, Map2, 0)} of
                        {1, 1} -> Acc + 1;
                        _ -> Acc
                    end
                end, 0, Words1).

count_occurrences(Words) ->
    lists:foldl(fun(Word, Map) ->
                    maps:update_with(Word, fun(Count) -> Count + 1 end, 1, Map)
                end, #{}, Words).
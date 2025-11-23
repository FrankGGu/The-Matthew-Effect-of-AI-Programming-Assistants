-spec split_words_by_separator(Words :: [unicode:unicode_binary()], Separator :: char()) -> [unicode:unicode_binary()].
split_words_by_separator(Words, Separator) ->
    lists:foldl(
        fun(Word, Acc) ->
            SplitParts = binary:split(Word, <<Separator>>, [global, trim]),
            lists:filter(fun(Part) -> byte_size(Part) > 0 end, SplitParts) ++ Acc
        end,
        [],
        Words
    ).
-spec reorder_spaces(Text :: unicode:unicode_binary()) -> unicode:unicode_binary().
reorder_spaces(Text) ->
    Words = string:lexemes(Text, " "),
    SpaceCount = length(string:lexemes(Text, [^ ])),
    WordCount = length(Words),
    if
        WordCount == 1 ->
            [Word] = Words,
            Spaces = lists:duplicate(SpaceCount, " "),
            unicode:characters_to_binary([Word | Spaces]);
        true ->
            EvenSpaces = SpaceCount div (WordCount - 1),
            ExtraSpaces = SpaceCount rem (WordCount - 1),
            SpaceStr = lists:duplicate(EvenSpaces, " "),
            Line = lists:join(SpaceStr, Words),
            ExtraSpaceStr = lists:duplicate(ExtraSpaces, " "),
            unicode:characters_to_binary([Line | ExtraSpaceStr])
    end.
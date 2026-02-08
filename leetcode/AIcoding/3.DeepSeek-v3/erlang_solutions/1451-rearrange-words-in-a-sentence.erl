-spec rearrange_words(Text :: unicode:unicode_binary()) -> unicode:unicode_binary().
rearrange_words(Text) ->
    Words = string:split(Text, " ", all),
    LowerWords = [string:to_lower(Word) || Word <- Words],
    WithLengths = [{length(Word), Word} || Word <- LowerWords],
    Sorted = lists:keysort(1, WithLengths),
    SortedWords = [Word || {_, Word} <- Sorted],
    Capitalized = capitalize_first(SortedWords),
    string:join(Capitalized, " ").

capitalize_first([]) -> [];
capitalize_first([Word | Rest]) ->
    [First | Tail] = Word,
    [string:to_upper(First) | Tail] ++ capitalize_first(Rest).
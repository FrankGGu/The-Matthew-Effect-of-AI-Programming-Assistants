-spec count_characters(Words :: [unicode:unicode_binary()], Chars :: unicode:unicode_binary()) -> integer().
count_characters(Words, Chars) ->
    CharCount = count_chars(Chars),
    lists:foldl(fun(Word, Acc) ->
        WordCount = count_chars(Word),
        case can_form(WordCount, CharCount) of
            true -> Acc + byte_size(Word);
            false -> Acc
        end
    end, 0, Words).

count_chars(Str) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, unicode:characters_to_list(Str)).

can_form(WordCount, CharCount) ->
    maps:fold(fun(Char, Count, Acc) ->
        case maps:get(Char, CharCount, 0) of
            C when C >= Count -> Acc;
            _ -> false
        end
    end, true, WordCount).
-spec num_of_strings(Patterns :: [unicode:unicode_binary()], Word :: unicode:unicode_binary()) -> integer().
num_of_strings(Patterns, Word) ->
    WordStr = binary_to_list(Word),
    lists:foldl(
        fun(Pattern, Acc) ->
            case binary:match(Word, Pattern) of
                nomatch -> Acc;
                _ -> Acc + 1
            end
        end,
        0,
        Patterns
    ).
-spec count_prefixes(Words :: [unicode:unicode_binary()], S :: unicode:unicode_binary()) -> integer().
count_prefixes(Words, S) ->
    lists:foldl(fun(Word, Acc) ->
        case string:prefix(S, Word) of
            nomatch -> Acc;
            _ -> Acc + 1
        end
    end, 0, Words).
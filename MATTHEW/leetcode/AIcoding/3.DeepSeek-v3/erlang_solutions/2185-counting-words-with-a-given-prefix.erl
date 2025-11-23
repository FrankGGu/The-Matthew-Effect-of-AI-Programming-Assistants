-spec count_prefixes(Words :: [unicode:unicode_binary()], Pref :: unicode:unicode_binary()) -> integer().
count_prefixes(Words, Pref) ->
    PrefSize = byte_size(Pref),
    lists:foldl(fun(Word, Acc) ->
        case Word of
            <<Pref:PrefSize/binary, _/binary>> -> Acc + 1;
            _ -> Acc
        end
    end, 0, Words).
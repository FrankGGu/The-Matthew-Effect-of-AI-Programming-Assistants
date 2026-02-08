-spec maximum_number_of_string_pairs(Words :: [unicode:unicode_binary()]) -> integer().
maximum_number_of_string_pairs(Words) ->
    Pairs = lists:foldl(fun(Word, Acc) ->
        Reversed = lists:reverse(binary_to_list(Word)),
        case lists:member(list_to_binary(Reversed), Words) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Words),
    Pairs div 2.
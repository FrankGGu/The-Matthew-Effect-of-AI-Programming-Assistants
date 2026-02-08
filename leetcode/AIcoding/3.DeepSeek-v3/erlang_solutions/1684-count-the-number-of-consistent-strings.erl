-spec count_consistent_strings(Allowed :: unicode:unicode_binary(), Words :: [unicode:unicode_binary()]) -> integer().
count_consistent_strings(Allowed, Words) ->
    AllowedSet = sets:from_list(binary_to_list(Allowed)),
    lists:foldl(fun(Word, Acc) ->
        case sets:is_subset(sets:from_list(binary_to_list(Word)), AllowedSet) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Words).
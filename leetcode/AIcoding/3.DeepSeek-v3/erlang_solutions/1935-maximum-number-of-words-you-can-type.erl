-spec can_be_typed_words(Text :: unicode:unicode_binary(), BrokenLetters :: unicode:unicode_binary()) -> integer().
can_be_typed_words(Text, BrokenLetters) ->
    Words = binary:split(Text, <<" ">>, [global]),
    BrokenSet = sets:from_list(binary_to_list(BrokenLetters)),
    lists:foldl(fun(Word, Count) ->
        case sets:is_disjoint(sets:from_list(binary_to_list(Word)), BrokenSet) of
            true -> Count + 1;
            false -> Count
        end
    end, 0, Words).
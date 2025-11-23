-spec sort_vowels(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
sort_vowels(S) ->
    Vowels = sets:from_list("aeiouAEIOU"),
    VowelList = lists:filter(fun(C) -> sets:is_element(C, Vowels) end, unicode:characters_to_list(S)),
    SortedVowels = lists:sort(VowelList),
    {Result, _} = lists:foldl(fun(C, {Acc, VowelsLeft}) ->
        case sets:is_element(C, Vowels) of
            true -> 
                [H | T] = VowelsLeft,
                {[H | Acc], T};
            false -> 
                {[C | Acc], VowelsLeft}
        end
    end, {[], SortedVowels}, lists:reverse(unicode:characters_to_list(S))),
    unicode:characters_to_binary(lists:reverse(Result)).
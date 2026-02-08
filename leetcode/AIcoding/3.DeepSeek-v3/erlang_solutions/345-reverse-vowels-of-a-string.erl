-spec reverse_vowels(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
reverse_vowels(S) ->
    Vowels = sets:from_list("aeiouAEIOU"),
    List = binary_to_list(S),
    VowelList = [C || C <- List, sets:is_element(C, Vowels)],
    ReversedVowels = lists:reverse(VowelList),
    {Result, _} = lists:foldl(fun(C, {Acc, Rev}) ->
        case sets:is_element(C, Vowels) of
            true -> {[hd(Rev) | Acc], tl(Rev)};
            false -> {[C | Acc], Rev}
        end
    end, {[], ReversedVowels}, List),
    list_to_binary(lists:reverse(Result)).
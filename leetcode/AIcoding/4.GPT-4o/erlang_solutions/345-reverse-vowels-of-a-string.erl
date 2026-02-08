-spec reverse_vowels(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
reverse_vowels(S) ->
    Vowels = "aeiouAEIOU",
    {ok, Chars} = unicode:characters_to_list(S),
    VowelChars = lists:filter(fun(Char) -> lists:member(Char, Vowels) end, Chars),
    reverse_vowels_helper(Chars, VowelChars, []).

reverse_vowels_helper([], _, Acc) -> lists:reverse(Acc);
reverse_vowels_helper([H | T], [V | VRest], Acc) when lists:member(H, "aeiouAEIOU") ->
    reverse_vowels_helper(T, VRest, Acc ++ [V]);
reverse_vowels_helper([H | T], Vowels, Acc) ->
    reverse_vowels_helper(T, Vowels, Acc ++ [H]).

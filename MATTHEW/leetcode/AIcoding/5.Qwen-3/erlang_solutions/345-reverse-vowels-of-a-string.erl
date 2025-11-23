-module(reverse_vowels).
-export([reverse_vowels/1]).

reverse_vowels(Str) ->
    Vowels = "aeiouAEIOU",
    List = string:to_list(Str),
    VowelIndices = [I || {C, I} <- lists:enumerate(List), lists:member(C, Vowels)],
    VowelChars = [lists:nth(I, List) || I <- VowelIndices],
    ReversedVowels = lists:reverse(VowelChars),
    reverse_vowels(List, VowelIndices, ReversedVowels, 1, []).

reverse_vowels([], [], _, _, Acc) ->
    lists:reverse(Acc);
reverse_vowels([H | T], [], _, _, Acc) ->
    reverse_vowels(T, [], _, 1, [H | Acc]);
reverse_vowels([H | T], [V | Vs], [R | Rs], I, Acc) ->
    if
        I == V ->
            reverse_vowels(T, Vs, Rs, I + 1, [R | Acc]);
        true ->
            reverse_vowels(T, [V | Vs], [R | Rs], I + 1, [H | Acc])
    end.
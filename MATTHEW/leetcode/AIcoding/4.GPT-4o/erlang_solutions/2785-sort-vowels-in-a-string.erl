-module(solution).
-export([sort_vowels/1]).

sort_vowels(S) ->
    Vowels = "aeiouAEIOU",
    VowelList = lists:filter(fun(Char) -> lists:member(Char, Vowels) end, string:to_list(S)),
    SortedVowels = lists:sort(VowelList),
    replace_vowels(string:to_list(S), SortedVowels, 0).

replace_vowels([], _, _) -> [];
replace_vowels([H|T], SortedVowels, Index) ->
    if
        lists:member(H, "aeiouAEIOU") ->
            [lists:nth(Index + 1, SortedVowels)|replace_vowels(T, SortedVowels, Index + 1)];
        true ->
            [H|replace_vowels(T, SortedVowels, Index)]
    end.
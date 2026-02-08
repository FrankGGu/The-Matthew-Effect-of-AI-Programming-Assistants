-module(solve).
-export([sort_vowels/1]).

sort_vowels(S) ->
    Vowels = "aeiouAEIOU",
    VowelList = [C || C <- S, lists:member(C, Vowels)],
    SortedVowels = lists:sort(VowelList),
    sort_vowels(S, SortedVowels, []).

sort_vowels([], _, Acc) ->
    lists:reverse(Acc);
sort_vowels([H | T], [V | Vt], Acc) ->
    sort_vowels(T, Vt, [V | Acc]);
sort_vowels([H | T], Vt, Acc) ->
    sort_vowels(T, Vt, [H | Acc]).
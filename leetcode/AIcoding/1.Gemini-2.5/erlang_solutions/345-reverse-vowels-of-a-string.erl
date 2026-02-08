-module(solution).
-export([reverseVowels/1]).

is_vowel(C) when C >= $A, C =< $Z -> is_vowel(C + 32);
is_vowel($a) -> true;
is_vowel($e) -> true;
is_vowel($i) -> true;
is_vowel($o) -> true;
is_vowel($u) -> true;
is_vowel(_) -> false.

get_vowels(S) ->
    [C || C <- S, is_vowel(C)].

reverseVowels(S) ->
    Vowels = get_vowels(S),
    ReversedVowels = lists:reverse(Vowels),
    replace_vowels(S, ReversedVowels, []).

replace_vowels([], _ReversedVowels, Acc) -> lists:reverse(Acc);
replace_vowels([H|T], ReversedVowels, Acc) ->
    case is_vowel(H) of
        true ->
            [NextVowel|RestReversedVowels] = ReversedVowels,
            replace_vowels(T, RestReversedVowels, [NextVowel|Acc]);
        false ->
            replace_vowels(T, ReversedVowels, [H|Acc])
    end.
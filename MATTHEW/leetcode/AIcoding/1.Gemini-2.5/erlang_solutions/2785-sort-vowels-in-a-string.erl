-module(solution).
-export([sort_vowels/1]).

is_vowel(C) when C >= $a, C =< $z ->
    C == $a orelse C == $e orelse C == $i orelse C == $o orelse C == $u;
is_vowel(C) when C >= $A, C =< $Z ->
    C == $A orelse C == $E orelse C == $I orelse C == $O orelse C == $U;
is_vowel(_) ->
    false.

sort_vowels(S) ->
    ExtractedVowels = [C || C <- S, is_vowel(C)],
    SortedVowels = lists:sort(ExtractedVowels),
    replace_vowels(S, SortedVowels, []).

replace_vowels([], _SortedVowels, Acc) ->
    lists:reverse(Acc);
replace_vowels([H|T], SortedVowels, Acc) ->
    case is_vowel(H) of
        true ->
            [VowelHead|VowelTail] = SortedVowels,
            replace_vowels(T, VowelTail, [VowelHead|Acc]);
        false ->
            replace_vowels(T, SortedVowels, [H|Acc])
    end.
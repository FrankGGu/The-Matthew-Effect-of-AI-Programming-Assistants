-module(solution).
-export([countBeautifulSubstrings/2]).

is_vowel(C) when C == $a; C == $e; C == $i; C == $o; C == $u -> true;
is_vowel(_) -> false.

countBeautifulSubstrings(S, K) ->
    S_list = string:to_list(S),
    count_beautiful(S_list, K, 0).

count_beautiful([], _K, Acc) -> Acc;
count_beautiful([H_char | T_list], K, Acc) ->
    Acc2 = count_beautiful_from_current_start([H_char | T_list], K, 0, 0, Acc),
    count_beautiful(T_list, K, Acc2).

count_beautiful_from_current_start([], _K, _Vowels, _Consonants, Acc) -> Acc;
count_beautiful_from_current_start([H_char | T_list], K, Vowels, Consonants, Acc) ->
    NewVowels = if is_vowel(H_char) -> Vowels + 1; true -> Vowels end,
    NewConsonants = if not is_vowel(H_char) -> Consonants + 1; true -> Consonants end,

    NewAcc = if
        NewVowels == NewConsonants andalso (NewVowels * NewConsonants) rem K == 0 ->
            Acc + 1;
        true ->
            Acc
    end,
    count_beautiful_from_current_start(T_list, K, NewVowels, NewConsonants, NewAcc).
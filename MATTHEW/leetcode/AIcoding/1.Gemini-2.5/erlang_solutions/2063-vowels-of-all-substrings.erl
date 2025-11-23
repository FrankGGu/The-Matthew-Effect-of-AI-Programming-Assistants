-module(solution).
-export([countVowels/1]).

countVowels(Word) ->
    N = length(Word),
    count_vowels_recursive(Word, 0, N, 0).

count_vowels_recursive([], _Index, _N, Acc) ->
    Acc;
count_vowels_recursive([H|T], Index, N, Acc) ->
    IsVowel = is_vowel(H),
    NewAcc = if IsVowel ->
                    Acc + (Index + 1) * (N - Index);
                true ->
                    Acc
             end,
    count_vowels_recursive(T, Index + 1, N, NewAcc).

is_vowel(C) ->
    C == $a orelse C == $e orelse C == $i orelse C == $o orelse C == $u.
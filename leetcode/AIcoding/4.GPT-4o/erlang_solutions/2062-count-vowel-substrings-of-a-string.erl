-module(solution).
-export([count_vowel_substrings/1]).

count_vowel_substrings(S) ->
    count_vowel_substrings(S, 0, 0, 0).

count_vowel_substrings([], _, Count, Acc) -> 
    Acc + Count;
count_vowel_substrings([H | T], VCount, Count, Acc) ->
    case is_vowel(H) of
        true ->
            count_vowel_substrings(T, VCount + 1, Count + 1, Acc);
        false ->
            count_vowel_substrings(T, 0, 0, Acc + Count * (Count + 1) div 2)
    end.

is_vowel(Char) ->
    Char =:= $a orelse Char =:= $e orelse Char =:= $i orelse Char =:= $o orelse Char =:= $u.
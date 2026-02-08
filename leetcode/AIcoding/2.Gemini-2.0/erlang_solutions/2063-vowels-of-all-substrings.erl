-module(vowels_of_all_substrings).
-export([count_vowels/1]).

count_vowels(S) ->
    Len = length(S),
    count_vowels_helper(S, Len, 0, 0).

count_vowels_helper(_S, 0, _Index, Acc) ->
    Acc;
count_vowels_helper(S, Len, Index, Acc) ->
    Char = element(1, string:substr(S, Index + 1, 1)),
    case is_vowel(Char) of
        true ->
            NewAcc = Acc + (Index + 1) * (Len - Index);
            count_vowels_helper(S, Len, Index + 1, NewAcc);
        false ->
            count_vowels_helper(S, Len, Index + 1, Acc)
    end.

is_vowel(Char) ->
    lists:member(Char, [$a, $e, $i, $o, $u, $A, $E, $I, $O, $U]).
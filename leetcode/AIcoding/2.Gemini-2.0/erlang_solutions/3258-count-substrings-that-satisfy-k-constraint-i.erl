-module(count_substrings_that_satisfy_k_constraint_i).
-export([count_substrings_that_satisfy_k_constraint_i/2]).

count_substrings_that_satisfy_k_constraint_i(S, K) ->
    count_substrings(S, K, 0).

count_substrings([], _K, Acc) ->
    Acc;
count_substrings(S, K, Acc) ->
    Len = length(S),
    count_valid_substrings(S, K, 1, Len, Acc).

count_valid_substrings(_S, _K, L, Len, Acc) when L > Len ->
    Acc;
count_valid_substrings(S, K, L, Len, Acc) ->
    case is_valid_substring(S, L, K) of
        true ->
            count_valid_substrings(S, K, L + 1, Len, Acc + 1);
        false ->
            count_valid_substrings(S, K, L + 1, Len, Acc)
    end.

is_valid_substring(S, L, K) ->
    is_valid_substring(S, 1, L, K, 0, []).

is_valid_substring(S, Start, L, K, Count, Vowels) when Start > L ->
    Count =< K;
is_valid_substring(S, Start, L, K, Count, Vowels) ->
    Char = lists:nth(Start, S),
    case is_vowel(Char) of
        true ->
            is_valid_substring(S, Start + 1, L, K, Count + 1, Vowels);
        false ->
            is_valid_substring(S, Start + 1, L, K, Count, Vowels)
    end.

is_vowel(Char) ->
    case Char of
        $a -> true;
        $e -> true;
        $i -> true;
        $o -> true;
        $u -> true;
        _ -> false
    end.
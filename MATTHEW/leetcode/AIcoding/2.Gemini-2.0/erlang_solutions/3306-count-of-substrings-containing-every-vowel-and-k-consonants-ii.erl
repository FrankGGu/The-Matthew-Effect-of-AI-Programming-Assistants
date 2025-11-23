-module(solution).
-export([count_substrings/2]).

count_substrings(S, K) ->
    count_substrings_helper(S, K, 0).

count_substrings_helper([], _K, Acc) ->
    Acc;
count_substrings_helper([H|T], K, Acc) ->
    count_substrings_helper(T, K, Acc + count_valid_substrings([H|T], K)).

count_valid_substrings(S, K) ->
    count_valid_substrings_helper(S, K, 0).

count_valid_substrings_helper([], _K, Acc) ->
    Acc;
count_valid_substrings_helper(S, K, Acc) ->
    Len = length(S),
    count_valid_substrings_helper2(S, 1, K, Len, Acc).

count_valid_substrings_helper2(S, L, K, Len, Acc) when L > Len ->
    Acc;
count_valid_substrings_helper2(S, L, K, Len, Acc) ->
    Sub = lists:sublist(S, L),
    case is_valid(Sub, K) of
        true ->
            count_valid_substrings_helper2(S, L + 1, K, Len, Acc + 1);
        false ->
            count_valid_substrings_helper2(S, L + 1, K, Len, Acc)
    end.

is_vowel(Char) ->
    lists:member(Char, "aeiou").

is_consonant(Char) ->
    not is_vowel(Char).

is_valid(S, K) ->
    Vowels = lists:usort([C || C <- S, is_vowel(C)]),
    Consonants = [C || C <- S, is_consonant(C)],
    length(Vowels) == 5 andalso count_consonants(Consonants) >= K.

count_consonants(Consonants) ->
  length(Consonants).
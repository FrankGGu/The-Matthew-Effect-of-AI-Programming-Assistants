-module(count_vowel_strings).
-export([vowel_strings/2]).

vowel_strings(Words, Queries) ->
    PrefixSum = calculate_prefix_sum(Words),
    [query_range(PrefixSum, Q) || Q <- Queries].

calculate_prefix_sum(Words) ->
    calculate_prefix_sum(Words, 0, []).

calculate_prefix_sum([], _, Acc) ->
    lists:reverse(Acc);
calculate_prefix_sum([H|T], Sum, Acc) ->
    NewSum = Sum + (is_vowel_string(H) band 1),
    calculate_prefix_sum(T, NewSum, [NewSum|Acc]).

is_vowel_string(Word) ->
    First = lists:nth(1, Word),
    Last = lists:nth(length(Word), Word),
    is_vowel(First) and is_vowel(Last).

is_vowel(Char) ->
    lists:member(Char, "aeiou").

query_range(PrefixSum, [L, R]) ->
    case L of
        0 ->
            lists:nth(R + 1, PrefixSum);
        _ ->
            lists:nth(R + 1, PrefixSum) - lists:nth(L, PrefixSum)
    end.
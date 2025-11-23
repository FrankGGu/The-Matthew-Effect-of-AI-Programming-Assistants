-module(vowels_of_all_substrings).
-export([count_vowels/1]).

count_vowels(S) ->
    Vowels = "aeiou",
    Count = 0,
    count_vowels(S, Vowels, Count, 0).

count_vowels([], _, Count, _) ->
    Count;
count_vowels([C | T], Vowels, Count, Index) ->
    case lists:member(C, Vowels) of
        true ->
            NewCount = Count + (Index + 1),
            count_vowels(T, Vowels, NewCount, Index + 1);
        false ->
            count_vowels(T, Vowels, Count, Index + 1)
    end.
-module(solution).
-export([count_vowel_substrings/1]).

count_vowel_substrings(S) ->
    Vowels = "aeiou",
    Count = 0,
    Length = erlang:length(S),
    count_vowel_substrings(S, Vowels, 0, Length, Count).

count_vowel_substrings(_, _, _, _, Count) when Count >= 0 -> Count;
count_vowel_substrings(S, Vowels, Start, Length, Count) ->
    case Start < Length of
        true ->
            Substring = erlang:substring(S, Start + 1),
            case is_vowel_string(Substring, Vowels) of
                true -> count_vowel_substrings(S, Vowels, Start + 1, Length, Count + 1);
                false -> count_vowel_substrings(S, Vowels, Start + 1, Length, Count)
            end;
        false -> Count
    end.

is_vowel_string([], _) -> true;
is_vowel_string([C | T], Vowels) ->
    case lists:member(C, Vowels) of
        true -> is_vowel_string(T, Vowels);
        false -> false
    end.
-module(solution).
-export([vowels_game/1]).

vowels_game(S) ->
    Vowels = "aeiou",
    Count = count_vowels(S, Vowels, 0),
    Count > 0.

count_vowels([], _Vowels, Acc) ->
    Acc;
count_vowels([H|T], Vowels, Acc) ->
    case lists:member(H, Vowels) of
        true -> count_vowels(T, Vowels, Acc + 1);
        false -> count_vowels(T, Vowels, Acc)
    end.
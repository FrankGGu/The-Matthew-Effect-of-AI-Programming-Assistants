-module(vowels_game_in_a_string).
-export([vowel_game/1]).

vowel_game(S) ->
    Vowels = "aeiou",
    Count = count_vowels(S, Vowels, 0),
    if
        Count rem 2 == 0 -> false;
        true -> true
    end.

count_vowels([], _, Acc) -> Acc;
count_vowels([H|T], Vowels, Acc) ->
    case lists:member(H, Vowels) of
        true -> count_vowels(T, Vowels, Acc + 1);
        false -> count_vowels(T, Vowels, Acc)
    end.
-module(vowels_game).
-export([count_vowels/1]).

count_vowels(S) ->
    Vowels = sets:from_list("aeiouAEIOU"),
    lists:foldl(fun(Char, Acc) ->
                    case sets:is_element(Char, Vowels) of
                        true -> Acc + 1;
                        false -> Acc
                    end
                end, 0, S).
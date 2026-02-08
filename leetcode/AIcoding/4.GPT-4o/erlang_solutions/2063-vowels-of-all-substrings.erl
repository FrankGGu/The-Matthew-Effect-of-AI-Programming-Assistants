-module(solution).
-export([countVowelsInSubstrings/1]).

countVowelsInSubstrings(S) ->
    Vowels = "aeiou",
    Length = string:length(S),
    lists:foldl(fun(Char, Acc) ->
        if
            lists:member(Char, Vowels) ->
                Acc + (Length - lists:position(Char, string:to_list(S)) + 1) * lists:position(Char, string:to_list(S));
            true ->
                Acc
        end
    end, 0, string:to_list(S)).
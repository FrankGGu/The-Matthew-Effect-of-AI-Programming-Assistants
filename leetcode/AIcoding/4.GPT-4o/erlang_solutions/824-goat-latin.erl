-module(solution).
-export([to_goat_latin/1]).

to_goat_latin(S) ->
    Words = string:tokens(S, " "),
    Vowels = "aeiouAEIOU",
    GoatLatinWords = lists:map(fun(W) -> 
        case lists:member(string:substr(W, 1, 1), Vowels) of
            true -> W ++ "ma";
            false -> string:substr(W, 2, string:length(W) - 1) ++ string:substr(W, 1, 1) ++ "ma"
        end ++ lists:duplicate(length(W) + 1, $a)
    end, Words),
    string:join(GoatLatinWords, " ").
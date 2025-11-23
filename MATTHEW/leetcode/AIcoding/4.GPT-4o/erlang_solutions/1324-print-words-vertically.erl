-module(solution).
-export([print_words_vertically/1]).

print_words_vertically(S) ->
    Words = string:tokens(S, " "),
    MaxLen = lists:max(lists:map(fun Word -> length(Word) end, Words)),
    lists:map(fun(Index) -> 
        lists:map(fun(Word) -> 
            case lists:nth(Index + 1, Word) of
                undefined -> $ ;
                Char -> Char
            end
        end, Words)
    end, lists:seq(0, MaxLen - 1)).
-module(length_of_last_word).
-export([length_of_last_word/1]).

length_of_last_word(S) ->
    Words = string:tokens(string:trim(S), " "),
    case Words of
        [] -> 0;
        _ -> length(lists:last(Words))
    end.
-module(solution).
-export([length_of_last_word/1]).

length_of_last_word(S) ->
    TrimmedS = string:trim(S),
    Words = string:tokens(TrimmedS, " "),
    LastWord = lists:last(Words),
    string:len(LastWord).
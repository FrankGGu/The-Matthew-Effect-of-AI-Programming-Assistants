-module(solution).
-export([reverseWords/1]).

reverseWords(S) ->
    TrimmedS = string:trim(S),
    Words = string:tokens(TrimmedS, " "),
    ReversedWords = lists:reverse(Words),
    string:join(ReversedWords, " ").
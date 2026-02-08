-module(solution).
-export([reverseWords/1]).

reverseWords(S) ->
    Trimmed = string:trim(S),
    Words = string:tokens(Trimmed, " "),
    FilteredWords = lists:filter(fun(W) -> W /= "" end, Words),
    ReversedWords = lists:reverse(FilteredWords),
    string:join(ReversedWords, " ").
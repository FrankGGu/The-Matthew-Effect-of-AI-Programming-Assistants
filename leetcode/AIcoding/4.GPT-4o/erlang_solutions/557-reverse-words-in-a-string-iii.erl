-module(solution).
-export([reverse_words/1]).

reverse_words(S) ->
    S1 = string:trim(S),
    Words = string:tokens(S1, " "),
    ReversedWords = lists:map(fun(W) -> lists:reverse(W) end, Words),
    string:join(ReversedWords, " ").
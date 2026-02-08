-module(solution).
-export([reverse_words/1]).

reverse_words(S) ->
    Words = string:tokens(S, " "),
    ReversedWords = [lists:reverse(Word) || Word <- Words],
    string:join(ReversedWords, " ").
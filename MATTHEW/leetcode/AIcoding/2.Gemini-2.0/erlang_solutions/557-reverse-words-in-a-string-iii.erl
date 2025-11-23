-module(reverse_words).
-export([reverseWords/1]).

reverseWords(S) ->
    Words = string:tokens(S, " "),
    ReversedWords = [lists:reverse(Word) || Word <- Words],
    string:join(ReversedWords, " ").
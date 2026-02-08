-module(reverse_words_in_a_string_iii).
-export([reverseWords/1]).

reverseWords(S) ->
    Words = string:tokens(S, " "),
    ReversedWords = [lists:reverse(W) || W <- Words],
    string:join(ReversedWords, " ").
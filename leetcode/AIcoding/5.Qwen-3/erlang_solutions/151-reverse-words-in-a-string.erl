-module(reverse_words_in_a_string).
-export([reverse_words/1]).

reverse_words(S) ->
    Words = string:tokens(S, " "),
    reverse_words(Words, []).

reverse_words([], Acc) ->
    string:join(lists:reverse(Acc), " ");
reverse_words([H|T], Acc) ->
    reverse_words(T, [H | Acc]).
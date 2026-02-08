-module(solution).
-export([reverse_words/1]).

reverse_words(S) ->
    Words = string:tokens(S, " "),
    reverse_words_list(Words, []).

reverse_words_list([], Acc) ->
    string:join(lists:reverse(Acc), " ");
reverse_words_list([H|T], Acc) ->
    reverse_words_list(T, [H | Acc]).
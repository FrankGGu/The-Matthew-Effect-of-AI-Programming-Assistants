-module(reverse_words).
-export([reverse_words/1]).

reverse_words(S) ->
  reverse_words_helper(string:tokens(S, " ")).

reverse_words_helper([]) ->
  "";
reverse_words_helper([H]) ->
  H;
reverse_words_helper([H|T]) ->
  reverse_words_helper(T) ++ " " ++ H.
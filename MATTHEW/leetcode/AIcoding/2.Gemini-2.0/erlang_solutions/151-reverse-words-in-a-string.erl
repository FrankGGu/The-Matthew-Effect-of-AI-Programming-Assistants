-module(reverse_words).
-export([reverse_words/1]).

reverse_words(S) ->
  Words = string:tokens(string:trim(S), " "),
  lists:reverse(Words) |> string:join(" ").
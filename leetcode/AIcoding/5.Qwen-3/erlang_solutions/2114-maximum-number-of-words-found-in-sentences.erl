-module(solution).
-export([most_words/1]).

most_words(Sentences) ->
    lists:max([length(words(S)) || S <- Sentences]).

words(S) ->
    string:tokens(S, " ").
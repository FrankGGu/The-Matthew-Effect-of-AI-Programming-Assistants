-module(solution).
-export([most_words/1]).

most_words(Sentences) ->
    Sentences 
    |> lists:map(fun(Sentence) -> length(string:tokens(Sentence, " ")) end)
    |> lists:max().
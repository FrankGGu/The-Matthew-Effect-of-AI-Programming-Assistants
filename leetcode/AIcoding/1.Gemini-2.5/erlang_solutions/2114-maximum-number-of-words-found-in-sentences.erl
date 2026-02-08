-module(solution).
-export([mostWordsFound/1]).

mostWordsFound(Sentences) ->
    WordCounts = [length(string:tokens(S, " ")) || S <- Sentences],
    lists:max(WordCounts).
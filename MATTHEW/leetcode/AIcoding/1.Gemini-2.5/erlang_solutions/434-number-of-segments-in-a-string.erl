-module(solution).
-export([countSegments/1]).

countSegments(S) ->
    length(string:tokens(S, " ")).
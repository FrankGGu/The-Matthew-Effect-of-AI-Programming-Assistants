-module(solution).
-export([countVowelStrings/1]).

countVowelStrings(N) ->
    (N + 4) * (N + 3) * (N + 2) * (N + 1) div 24.
-module(solution).
-export([countOdds/2]).

countOdds(L, R) ->
    (R div 2) - ((L - 1) div 2).
-module(solution).
-export([minCount/1]).

minCount(Coins) ->
    lists:sum([ (C + 1) div 2 || C <- Coins ]).
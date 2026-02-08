-module(solution).
-export([min_coins/1]).

min_coins(Coins) ->
    lists:sum([ (C + 1) div 2 || C <- Coins ]).
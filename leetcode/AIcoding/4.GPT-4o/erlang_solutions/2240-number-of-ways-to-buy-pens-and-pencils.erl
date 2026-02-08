-module(solution).
-export([ways_to_buy_pens_and_pencils/2]).

ways_to_buy_pens_and_pencils(P, T) ->
    TotalWays = fun(N) -> (T - N * P) div 2 + 1 end,
    lists:sum(lists:map(TotalWays, lists:seq(0, T div P))).
-module(solution).
-export([maximum_spending/1]).

maximum_spending(Prices) ->
    N = length(Prices),
    SumPrices = lists:sum(Prices),
    SumK = N * (N + 1) div 2,
    SumPrices + SumK.
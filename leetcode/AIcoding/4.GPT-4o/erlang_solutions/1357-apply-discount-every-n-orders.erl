-module(solution).
-export([discountedPrices/2]).

discountedPrices(Prices, n) ->
    lists:map(fun(P, Index) ->
        if (Index rem n) == (n - 1) -> 
            P * 0.9;
        true -> 
            P
        end
    end, Prices, lists:seq(0, length(Prices) - 1)).
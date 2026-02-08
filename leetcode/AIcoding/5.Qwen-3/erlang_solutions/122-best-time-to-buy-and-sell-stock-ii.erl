-module(solution).
-export([max_profit/1]).

max_profit(Prices) ->
    max_profit(Prices, 0).

max_profit([], Profit) ->
    Profit;
max_profit([_], Profit) ->
    Profit;
max_profit([P1, P2 | Rest], Profit) ->
    if
        P2 > P1 ->
            max_profit([P2 | Rest], Profit + P2 - P1);
        true ->
            max_profit([P2 | Rest], Profit)
    end.
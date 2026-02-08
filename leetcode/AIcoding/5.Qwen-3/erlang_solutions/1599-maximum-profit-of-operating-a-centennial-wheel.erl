-module(solution).
-export([max_profit/2]).

max_profit(R, C) ->
    max_profit(R, C, 0, 0).

max_profit([], _, _, Profit) ->
    Profit;
max_profit([T | Rest], C, Count, Profit) ->
    if
        Count >= T ->
            NewProfit = Profit + 1,
            max_profit(Rest, C, Count - T, NewProfit);
        true ->
            max_profit(Rest, C, Count + 1, Profit)
    end.
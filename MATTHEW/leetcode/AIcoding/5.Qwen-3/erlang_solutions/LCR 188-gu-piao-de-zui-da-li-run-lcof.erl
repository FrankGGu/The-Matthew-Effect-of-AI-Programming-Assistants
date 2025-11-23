-module(best_time_to_buy_and_sell_stock).
-export([max_profit/1]).

max_profit(Prices) ->
    max_profit(Prices, 0, 1, 0).

max_profit([], _, _, MaxProfit) ->
    MaxProfit;
max_profit([Price | Rest], Index, MinIndex, MaxProfit) ->
    CurrentMin = lists:nth(MinIndex, Prices),
    CurrentProfit = Price - CurrentMin,
    NewMaxProfit = max(MaxProfit, CurrentProfit),
    if
        Price < CurrentMin ->
            max_profit(Rest, Index + 1, Index + 1, NewMaxProfit);
        true ->
            max_profit(Rest, Index + 1, MinIndex, NewMaxProfit)
    end.
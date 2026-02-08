-module(best_time_to_buy_sell_stock).
-export([max_profit/1]).

max_profit(Prices) ->
    max_profit(Prices, infinity, 0).

max_profit([], _MinPrice, MaxProfit) ->
    MaxProfit;
max_profit([Price | Rest], MinPrice, MaxProfit) ->
    NewMinPrice = min(MinPrice, Price),
    NewMaxProfit = max(MaxProfit, Price - MinPrice),
    max_profit(Rest, NewMinPrice, NewMaxProfit).
-module(solution).
-export([max_profit/1]).

max_profit(Prices) ->
    max_profit_acc(Prices, infinity, 0).

max_profit_acc([], _MinPrice, MaxProfit) ->
    MaxProfit;
max_profit_acc([Price | Rest], MinPrice, MaxProfit) ->
    NewMinPrice = min_val(MinPrice, Price),
    CurrentProfit = Price - NewMinPrice,
    NewMaxProfit = erlang:max(MaxProfit, CurrentProfit),
    max_profit_acc(Rest, NewMinPrice, NewMaxProfit).

min_val(infinity, Val) -> Val;
min_val(Val1, Val2) -> erlang:min(Val1, Val2).
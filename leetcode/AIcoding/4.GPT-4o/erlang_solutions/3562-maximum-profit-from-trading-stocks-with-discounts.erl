-module(solution).
-export([max_profit/2]).

max_profit(Prices, Discounts) ->
    max_profit_helper(Prices, Discounts, 0).

max_profit_helper([], [], Profit) -> 
    Profit;
max_profit_helper([Price | Prices], [Discount | Discounts], Profit) ->
    NewProfit = max(Profit, Price - Discount),
    max_profit_helper(Prices, Discounts, NewProfit);
max_profit_helper([_ | Prices], [], Profit) ->
    max_profit_helper(Prices, [], Profit).
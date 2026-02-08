-module(solution).
-export([max_profit/2]).

max_profit(Balls, MaxSell) ->
    Lists = lists:sort(Balls),
    MaxSellCount = lists:sum(Lists),
    max_profit_helper(Lists, MaxSell, MaxSellCount, 0).

max_profit_helper([], _, _, Profit) -> Profit;
max_profit_helper([Count | Rest], MaxSell, MaxSellCount, Profit) ->
    SellCount = min(Count, MaxSell),
    NewProfit = Profit + SellCount * (MaxSellCount - Count + 1),
    max_profit_helper(Rest, MaxSell - SellCount, MaxSellCount, NewProfit).
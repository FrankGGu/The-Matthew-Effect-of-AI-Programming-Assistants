-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
    max_profit(Prices, 0, 0).

max_profit([], MaxProfit, _MinPrice) ->
    MaxProfit;
max_profit([Price | Rest], MaxProfit, MinPrice) ->
    NewMinPrice = min(Price, MinPrice),
    NewMaxProfit = max(Price - NewMinPrice, MaxProfit),
    max_profit(Rest, NewMaxProfit, NewMinPrice).
-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
    max_profit(Prices, 0, 0).

max_profit([], Min, MaxProfit) ->
    MaxProfit;
max_profit([Price | Rest], Min, MaxProfit) ->
    NewMin = min(Price, Min),
    Profit = Price - Min,
    NewMaxProfit = max(Profit, MaxProfit),
    max_profit(Rest, NewMin, NewMaxProfit).
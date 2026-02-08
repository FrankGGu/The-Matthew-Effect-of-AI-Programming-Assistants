-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
    max_profit(Prices, 0, hd(Prices)).

max_profit([], MaxProfit, _) -> MaxProfit;
max_profit([Price | Rest], MaxProfit, MinPrice) ->
    NewMaxProfit = max(MaxProfit, Price - MinPrice),
    NewMinPrice = min(MinPrice, Price),
    max_profit(Rest, NewMaxProfit, NewMinPrice).

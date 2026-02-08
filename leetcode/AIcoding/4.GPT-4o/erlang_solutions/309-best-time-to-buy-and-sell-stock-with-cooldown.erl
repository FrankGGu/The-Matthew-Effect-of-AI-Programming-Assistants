-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
    max_profit(Prices, 0, 0, 0).

max_profit([], Cash, _, _) -> Cash;
max_profit([Price | Rest], Cash, Buy, Sell) ->
    NoAction = max(Cash, Sell),
    BuyNow = max(Buy, Cash - Price),
    SellNow = Buy + Price,
    max_profit(Rest, NoAction, BuyNow, SellNow).

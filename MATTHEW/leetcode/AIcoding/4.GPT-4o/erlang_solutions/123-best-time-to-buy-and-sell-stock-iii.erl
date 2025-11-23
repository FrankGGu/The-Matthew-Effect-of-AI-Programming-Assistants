-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
    max_profit(Prices, 0, 0, 0).

max_profit([], Profit, _, _) -> Profit;
max_profit([Price | Rest], Profit, Buy1, Buy2) ->
    max_profit(Rest, max(Profit, Price - Buy1),
                min(Buy1, Price), min(Buy2, Price - Profit)).

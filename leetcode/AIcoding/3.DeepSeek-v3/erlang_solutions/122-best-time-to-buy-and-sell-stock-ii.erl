-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
    lists:foldl(fun({X, Y}, Acc) -> Acc + max(0, Y - X) end, 0, lists:zip(Prices, tl(Prices))).
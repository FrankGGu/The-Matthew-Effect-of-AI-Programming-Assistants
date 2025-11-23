-spec max_profit(Prices :: [integer()], Fee :: integer()) -> integer().
max_profit(Prices, Fee) ->
    max_profit(Prices, Fee, 0, -lists:nth(1, Prices)).

max_profit([], _Fee, Cash, Hold) ->
    Cash;
max_profit([Price | Rest], Fee, Cash, Hold) ->
    NewCash = max(Cash, Hold + Price - Fee),
    NewHold = max(Hold, Cash - Price),
    max_profit(Rest, Fee, NewCash, NewHold).
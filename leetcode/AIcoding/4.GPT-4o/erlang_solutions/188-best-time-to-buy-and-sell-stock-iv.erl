-spec max_profit(K :: integer(), Prices :: [integer()]) -> integer().
max_profit(K, Prices) when K > 0, Prices /= [] ->
    max_profit(K, Prices, length(Prices), lists:duplicate(K, 0), lists:duplicate(K, 0)).

max_profit(_, _, 0, _, _) -> 0;
max_profit(K, Prices, Day, Profit, Hold) ->
    max_profit(K, Prices, Day - 1, update_profit(Day, K, Prices, Profit, Hold), update_hold(Day, K, Prices, Hold)).

update_profit(Day, K, Prices, Profit, Hold) ->
    lists:map(fun(I) -> max(Profit(I), Hold(I) + Prices:element(Day, Prices) - Prices:element(Day - 1, Prices)) end, lists:seq(1, K)).

update_hold(Day, K, Prices, Hold) ->
    lists:map(fun(I) -> max(Hold(I), Profit(I) - Prices:element(Day, Prices)) end, lists:seq(1, K)).

-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
    max_profit(Prices, 0, 0).

max_profit([], Profit, _) -> Profit;
max_profit([_], Profit, _) -> Profit;
max_profit([Price1, Price2 | Tail], Profit, PrevPrice) when Price2 > PrevPrice ->
    max_profit([Price2 | Tail], Profit + (Price2 - PrevPrice), Price2);
max_profit([_ | Tail], Profit, PrevPrice) ->
    max_profit(Tail, Profit, PrevPrice).

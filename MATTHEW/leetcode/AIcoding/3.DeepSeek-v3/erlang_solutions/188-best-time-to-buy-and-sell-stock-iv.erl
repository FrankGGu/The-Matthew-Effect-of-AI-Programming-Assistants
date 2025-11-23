-spec max_profit(K :: integer(), Prices :: [integer()]) -> integer().
max_profit(K, Prices) ->
    N = length(Prices),
    if 
        N =< 1 -> 0;
        true ->
            MaxK = min(K, N div 2),
            Buy = lists:duplicate(MaxK + 1, -1000000),
            Sell = lists:duplicate(MaxK + 1, 0),
            do_max_profit(Prices, Buy, Sell)
    end.

do_max_profit([], Buy, Sell) ->
    lists:max(Sell);
do_max_profit([Price | Rest], Buy, Sell) ->
    NewBuy = [max(lists:nth(1, Buy), -Price) | lists:sublist(Buy, 2, length(Buy) - 1)],
    NewSell = lists:foldl(fun(K, Acc) ->
        MaxBuy = lists:nth(K, Buy),
        MaxSellPrev = lists:nth(K - 1, Sell),
        NewSellK = max(lists:nth(K, Acc), MaxBuy + Price),
        NewBuyK = max(lists:nth(K, NewBuy), MaxSellPrev - Price),
        lists:sublist(Acc, K - 1) ++ [NewSellK] ++ lists:nthtail(K, Acc)
    end, Sell, lists:seq(2, length(Sell))),
    do_max_profit(Rest, NewBuy, NewSell).
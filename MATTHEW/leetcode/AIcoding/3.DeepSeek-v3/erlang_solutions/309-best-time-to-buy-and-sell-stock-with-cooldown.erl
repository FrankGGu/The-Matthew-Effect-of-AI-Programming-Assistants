-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
    N = length(Prices),
    if 
        N =< 1 -> 0;
        true ->
            DP = lists:duplicate(N, {0, 0, 0}),
            {DP1, _} = lists:mapfoldl(fun(Price, {PrevBuy, PrevSell, PrevCooldown}) ->
                Buy = max(PrevBuy, PrevCooldown - Price),
                Sell = PrevBuy + Price,
                Cooldown = max(PrevSell, PrevCooldown),
                {{Buy, Sell, Cooldown}, {Buy, Sell, Cooldown}}
            end, {-lists:nth(1, Prices), 0, 0}, Prices),
            {_, Sell, Cooldown} = lists:last(DP1),
            max(Sell, Cooldown)
    end.
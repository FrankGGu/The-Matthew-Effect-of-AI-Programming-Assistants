-module(modulecoinchange).
-module (coin_change).
-export ([coin_change/2]).

coin_change(Coins, Amount) ->
    Max = Amount + 1,
    DP = array:new(Amount + 1, {default, Max}),
    array:set(0, 0, DP),
    coin_change(Coins, Amount, DP).

coin_change([], _, DP) ->
    case array:get(Amount, DP) of
        Max when Max == Amount + 1 -> -1;
        Val -> Val
    end;

coin_change([Coin | Coins], Amount, DP) ->
    coin_change(Coins, Amount, update_dp(DP, Coin, Amount)).

update_dp(DP, Coin, Amount) ->
    update_dp(DP, Coin, Amount, 0).

update_dp(DP, Coin, Amount, I) when I > Amount ->
    DP;

update_dp(DP, Coin, Amount, I) ->
    if
        I >= Coin ->
            Prev = array:get(I - Coin, DP),
            Current = array:get(I, DP),
            if
                Prev + 1 < Current -> array:set(I, Prev + 1, DP);
                true -> DP
            end;
        true ->
            DP
    end,
    update_dp(DP, Coin, Amount, I + 1).
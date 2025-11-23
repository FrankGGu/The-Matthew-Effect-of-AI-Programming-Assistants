-module(coin_change_ii).
-export([change/2]).

change(Amount, Coins) ->
    change(Amount, Coins, []).

change(0, _, Acc) ->
    length(Acc);
change(Amount, [], _) ->
    0;
change(Amount, [Coin | Rest], Acc) ->
    if
        Amount < 0 ->
            0;
        true ->
            change(Amount, Rest, Acc) + change(Amount - Coin, [Coin | Rest], [Coin | Acc])
    end.
```
```erlang
-module(coin_change_ii).
-export([change/2]).

change(Amount, Coins) ->
    N = length(Coins),
    DP = array:new([Amount + 1, N + 1], {fixed, 0}),
    array:set({0, 0}, 1, DP),

    lists:foreach(
        fun(I) ->
            Coin = lists:nth(I, Coins),
            lists:foreach(
                fun(A) ->
                    Prev = array:get({A, I - 1}, DP),
                    WithCoin =
                        if A - Coin >= 0 ->
                            array:get({A - Coin, I}, DP)
                        else
                            0
                        end,
                    array:set({A, I}, Prev + WithCoin, DP)
                end,
                lists:seq(0, Amount)
            )
        end,
        lists:seq(1, N)
    ),
    array:get({Amount, N}, DP).
```
```erlang
-module(coin_change_ii).
-export([change/2]).

change(Amount, Coins) ->
    N = length(Coins),
    DP = lists:duplicate(Amount + 1, 0),
    DP ! put(1, 1),

    lists:foreach(
        fun(Coin) ->
            lists:foreach(
                fun(A) ->
                    if A >= Coin ->
                        DP ! put(A + 1, (get(A + 1, DP) + get(A - Coin + 1, DP)))
                    else
                        ok
                    end
                end,
                lists:seq(Coin, Amount)
            )
        end,
        Coins
    ),
    get(Amount + 1, DP).

get(Key, State) ->
    case proplists:get_value(Key, State) of
        undefined -> 0;
        Value -> Value
    end.
```
```erlang
-module(coin_change_ii).
-export([change/2]).

change(Amount, Coins) ->
    N = length(Coins),
    DP = lists:duplicate(Amount + 1, 0),
    DP_updated = lists:nthreplace(1, 1, DP),

    lists:foldl(
        fun(Coin, Acc) ->
            lists:foldl(
                fun(A, Acc2) ->
                    if A >= Coin ->
                        lists:nthreplace(A + 1, lists:nth(A + 1, Acc2) + lists:nth(A - Coin + 1, Acc2), Acc2)
                    else
                        Acc2
                    end
                end,
                Acc,
                lists:seq(Coin, Amount)
            )
        end,
        DP_updated,
        Coins
    )!!(Amount + 1).
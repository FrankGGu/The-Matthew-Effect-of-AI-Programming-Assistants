-module(coin_change).
-export([coin_change/2]).

coin_change(Coins, Amount) ->
    coin_change(Coins, Amount, []).

coin_change(Coins, 0, Acc) ->
    length(Acc);
coin_change(Coins, Amount, Acc) when Amount < 0 ->
    -1;
coin_change([], Amount, Acc) ->
    -1;
coin_change([Coin|Rest], Amount, Acc) ->
    Case1 = coin_change(Coins, Amount - Coin, [Coin|Acc]),
    Case2 = coin_change(Rest, Amount, Acc),
    if
        Case1 == -1 ->
            Case2;
        Case2 == -1 ->
            Case1;
        true ->
            min(Case1, Case2)
    end.

min(A, B) ->
    if A < B -> A;
    true -> B
    end.
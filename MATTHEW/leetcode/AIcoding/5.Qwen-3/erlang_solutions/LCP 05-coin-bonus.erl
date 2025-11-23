-module(coin_bonus).
-export([max_bonuses/1]).

max_bonuses(Coins) ->
    max_bonuses(Coins, 0, 0).

max_bonuses([], Acc, _), Acc;
max_bonuses([H | T], Acc, Prev) when H == Prev ->
    max_bonuses(T, Acc, H);
max_bonuses([H | T], Acc, _Prev) ->
    max_bonuses(T, Acc + 1, H).
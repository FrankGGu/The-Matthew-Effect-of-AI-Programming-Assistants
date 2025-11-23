-module(max_ice_cream).
-export([max_ice_cream/2]).

max_ice_cream(Cost, coins) ->
    Sorted = lists:sort(Cost),
    max_ice_cream(Sorted, coins, 0).

max_ice_cream([], _, Count) ->
    Count;
max_ice_cream([H | T], Coins, Count) when H =< Coins ->
    max_ice_cream(T, Coins - H, Count + 1);
max_ice_cream(_, _, Count) ->
    Count.
-module(maximum_ice_cream_bars).
-export([max_ice_cream/2]).

max_ice_cream(Costs, Coins) ->
    SortedCosts = lists:sort(Costs),
    max_ice_cream_helper(SortedCosts, Coins, 0).

max_ice_cream_helper([], _, Count) ->
    Count;
max_ice_cream_helper([Cost | Rest], Coins, Count) ->
    if
        Cost =< Coins ->
            max_ice_cream_helper(Rest, Coins - Cost, Count + 1);
        true ->
            Count
    end.
-module(solution).
-export([maxIceCream/2]).

-spec maxIceCream(Costs :: [integer()], Coins :: integer()) -> integer().
maxIceCream(Costs, Coins) ->
    SortedCosts = lists:sort(Costs),
    buy_ice_cream(SortedCosts, Coins, 0).

buy_ice_cream([], _Coins, Count) ->
    Count;
buy_ice_cream([Cost | Rest], Coins, Count) when Coins >= Cost ->
    buy_ice_cream(Rest, Coins - Cost, Count + 1);
buy_ice_cream([_Cost | _Rest], _Coins, Count) ->
    Count.
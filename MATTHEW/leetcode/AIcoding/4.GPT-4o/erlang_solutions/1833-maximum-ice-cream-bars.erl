-module(solution).
-export([maxIceCream/2]).

maxIceCream(Money, Costs) ->
    SortedCosts = lists:sort(Costs),
    max_ice_cream_helper(Money, SortedCosts, 0).

max_ice_cream_helper(_, [], Count) ->
    Count;
max_ice_cream_helper(Money, [Cost | Rest], Count) when Money >= Cost ->
    max_ice_cream_helper(Money - Cost, Rest, Count + 1);
max_ice_cream_helper(_, _, Count) ->
    Count.
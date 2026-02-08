-module(minimum_cost).
-export([minimum_cost/1]).

minimum_cost(Cost) ->
    SortedCost = lists:sort(Cost),
    minimum_cost_helper(SortedCost, 0, 0).

minimum_cost_helper([], Acc, _) ->
    Acc;
minimum_cost_helper([C1, C2, C3 | Rest], Acc, _) ->
    minimum_cost_helper(Rest, Acc + C1 + C2, _);
minimum_cost_helper([C1, C2], Acc, _) ->
    Acc + C1 + C2;
minimum_cost_helper([C1], Acc, _) ->
    Acc + C1.
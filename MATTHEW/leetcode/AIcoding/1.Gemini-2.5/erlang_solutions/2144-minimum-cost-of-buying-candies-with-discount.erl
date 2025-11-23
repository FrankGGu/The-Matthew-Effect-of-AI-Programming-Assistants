-module(solution).
-export([minimum_cost/1]).

-spec minimum_cost(Cost :: [integer()]) -> integer().
minimum_cost(Cost) ->
    SortedCost = lists:reverse(lists:sort(Cost)),
    calculate_cost(SortedCost, 0).

calculate_cost([], Acc) ->
    Acc;
calculate_cost([C1, C2, _C3 | Rest], Acc) ->
    calculate_cost(Rest, Acc + C1 + C2);
calculate_cost([C1, C2 | Rest], Acc) ->
    calculate_cost(Rest, Acc + C1 + C2);
calculate_cost([C1 | Rest], Acc) ->
    calculate_cost(Rest, Acc + C1).
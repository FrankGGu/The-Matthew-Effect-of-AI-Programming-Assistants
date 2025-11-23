-module(inventory_management_ii).
-export([find_min_cost/1]).

find_min_cost(inventory) ->
    find_min_cost(inventory, 0).

find_min_cost([], Acc) ->
    Acc;
find_min_cost([H|T], Acc) ->
    find_min_cost(T, Acc + H).
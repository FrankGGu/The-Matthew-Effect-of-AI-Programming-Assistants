-module(solution).
-export([min_cost/1]).

min_cost(Nums) ->
    min_cost(Nums, 0, 0).

min_cost([], _, Cost) ->
    Cost;
min_cost([H | T], Index, Cost) ->
    NextIndex = Index + 1,
    NewCost = Cost + (H * NextIndex),
    min_cost(T, NextIndex, NewCost).
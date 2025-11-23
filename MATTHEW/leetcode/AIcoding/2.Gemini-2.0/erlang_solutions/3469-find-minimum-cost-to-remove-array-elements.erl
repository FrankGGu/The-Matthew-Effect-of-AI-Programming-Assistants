-module(find_minimum_cost_to_remove_array_elements).
-export([minimumCost/1]).

minimumCost(Nums) ->
    minimumCost(Nums, 0).

minimumCost([], Acc) ->
    Acc;
minimumCost(Nums, Acc) ->
    Min = lists:min(Nums),
    NewAcc = Acc + Min * length(Nums),
    NewNums = [X - Min || X <- Nums],
    PositiveNums = [X || X <- NewNums, X > 0],
    minimumCost(PositiveNums, NewAcc).
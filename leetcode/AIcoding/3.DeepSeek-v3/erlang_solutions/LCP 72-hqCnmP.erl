-module(solution).
-export([supply_wagon/1]).

supply_wagon(Nums) ->
    K = length(Nums) div 2,
    supply_wagon(Nums, K).

supply_wagon(Nums, 0) ->
    Nums;
supply_wagon(Nums, K) ->
    {MinIdx, _} = lists:min(lists:zip(lists:seq(1, length(Nums) - 1, 
                            [lists:nth(I, Nums) + lists:nth(I + 1, Nums) || I <- lists:seq(1, length(Nums) - 1)])),
    NewNums = lists:sublist(Nums, MinIdx - 1) ++ [lists:nth(MinIdx, Nums) + lists:nth(MinIdx + 1, Nums)] ++ lists:nthtail(MinIdx + 1, Nums),
    supply_wagon(NewNums, K - 1).
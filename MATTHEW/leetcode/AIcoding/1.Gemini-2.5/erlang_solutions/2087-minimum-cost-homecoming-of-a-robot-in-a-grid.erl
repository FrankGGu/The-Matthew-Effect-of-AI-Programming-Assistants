-module(solution).
-export([minCost/4]).

-include_lib("array/include/array.hrl").

minCost(StartPos, HomePos, RowCostsList, ColCostsList) ->
    [Sr, Sc] = StartPos,
    [Hr, Hc] = HomePos,

    RowCostsArray = array:from_list(RowCostsList),
    ColCostsArray = array:from_list(ColCostsList),

    RowCost = calculate_dim_cost(Sr, Hr, RowCostsArray),
    ColCost = calculate_dim_cost(Sc, Hc, ColCostsArray),

    RowCost + ColCost.

calculate_dim_cost(Current, Target, CostsArray) when Current == Target ->
    0;
calculate_dim_cost(Current, Target, CostsArray) when Current < Target ->
    Sum = lists:foldl(fun(Idx, Acc) -> Acc + array:get(Idx, CostsArray) end, 0, lists:seq(Current + 1, Target)),
    Sum;
calculate_dim_cost(Current, Target, CostsArray) when Current > Target ->
    Sum = lists:foldl(fun(Idx, Acc) -> Acc + array:get(Idx, CostsArray) end, 0, lists:seq(Target, Current - 1)),
    Sum.
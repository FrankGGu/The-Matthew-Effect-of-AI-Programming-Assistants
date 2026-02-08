-module(solution).
-export([zigzag/1]).

-include_lib("kernel/include/array.hrl").

zigzag(Nums) ->
    Len = length(Nums),
    if
        Len =< 1 -> 0;
        true ->
            Arr = array:from_list(Nums),
            CostEvenPeaks = calculate_cost_by_modifying_neighbors(Arr, Len, 0),
            CostOddPeaks = calculate_cost_by_modifying_neighbors(Arr, Len, 1),
            min(CostEvenPeaks, CostOddPeaks)
    end.

calculate_cost_by_modifying_neighbors(OriginalArr, Len, StartIdx) ->
    calculate_cost_by_modifying_neighbors_acc(Len, StartIdx, 0, OriginalArr).

calculate_cost_by_modifying_neighbors_acc(Len, CurrentIdx, AccCost, TempArr) when CurrentIdx >= Len ->
    AccCost;
calculate_cost_by_modifying_neighbors_acc(Len, CurrentIdx, AccCost, TempArr) ->
    CurrentVal = array:get(CurrentIdx, TempArr),

    UpdatedAccCost1 = AccCost,
    UpdatedTempArr1 = TempArr,

    % Check left neighbor
    {NextAccCost1, NextTempArr1} = 
        if CurrentIdx > 0 ->
            LeftNeighborVal = array:get(CurrentIdx - 1, TempArr),
            if LeftNeighborVal >= CurrentVal ->
                DecreaseAmount = LeftNeighborVal - CurrentVal + 1,
                {UpdatedAccCost1 + DecreaseAmount, array:set(CurrentIdx - 1, CurrentVal - 1, UpdatedTempArr1)};
            true ->
                {UpdatedAccCost1, UpdatedTempArr1}
            end;
        true ->
            {UpdatedAccCost1, UpdatedTempArr1}
        end,

    % Check right neighbor
    {FinalAccCost, FinalTempArr} = 
        if CurrentIdx < Len - 1 ->
            RightNeighborVal = array:get(CurrentIdx + 1, NextTempArr1),
            if RightNeighborVal >= CurrentVal ->
                DecreaseAmount = RightNeighborVal - CurrentVal + 1,
                {NextAccCost1 + DecreaseAmount, array:set(CurrentIdx + 1, CurrentVal - 1, NextTempArr1)};
            true ->
                {NextAccCost1, NextTempArr1}
            end;
        true ->
            {NextAccCost1, NextTempArr1}
        end,

    calculate_cost_by_modifying_neighbors_acc(Len, CurrentIdx + 2, FinalAccCost, FinalTempArr).
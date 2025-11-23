-module(solution).
-export([connect_two_groups/1]).

-define(INF, 1 bsl 30). % A sufficiently large number for infinity

connect_two_groups(Cost) ->
    N = length(Cost),
    M = length(hd(Cost)),

    % Precompute minimum cost to connect each group2 point to any group1 point
    % MinCostJ[j] = min(cost[i][j] for i in 0 to N-1)
    MinCostJ_Array = array:new({size, M}),
    MinCostJ_Final = lists:foldl(fun(J, AccMinCostJ) ->
        MinVal = lists:foldl(fun(Row, CurrentMin) ->
            min(CurrentMin, lists:nth(J + 1, Row))
        end, ?INF, Cost),
        array:set(J, MinVal, AccMinCostJ)
    end, MinCostJ_Array, lists:seq(0, M - 1)),

    % Initialize DP table: dp[mask] = min cost to connect all N group1 points
    % such that group2 points in 'mask' are connected.
    MaxMask = (1 bsl M) - 1,
    DP_Initial = array:new({size, MaxMask + 1}, {default, ?INF}),
    DP_Initial_Set = array:set(0, 0, DP_Initial),

    % Iterate through each group1 point (from 0 to N-1)
    FinalDP = lists:foldl(fun(I, CurrentDP) ->
        NewDP = array:new({size, MaxMask + 1}, {default, ?INF}),
        CostRow = lists:nth(I + 1, Cost), % Cost values for group1 point I

        lists:foldl(fun(Mask, AccNewDP) ->
            MaskCost = array:get(Mask, CurrentDP),
            if MaskCost == ?INF ->
                AccNewDP;
            true ->
                % Connect group1 point I to each group2 point J
                lists:foldl(fun(J, AccInnerNewDP) ->
                    NewMask = Mask bor (1 bsl J),
                    CurrentJCost = lists:nth(J + 1, CostRow),
                    array:set(NewMask, min(array:get(NewMask, AccInnerNewDP), MaskCost + CurrentJCost), AccInnerNewDP)
                end, AccNewDP, lists:seq(0, M - 1))
            end
        end, NewDP, lists:seq(0, MaxMask))
    end, DP_Initial_Set, lists:seq(0, N - 1)),

    % Calculate the final minimum cost
    % Iterate through all possible masks for group2 points that were connected
    % by group1 points. Add costs for any remaining unconnected group2 points.
    Ans = lists:foldl(fun(Mask, CurrentMinAns) ->
        CurrentTotalCost = array:get(Mask, FinalDP),
        if CurrentTotalCost == ?INF ->
            CurrentMinAns;
        true ->
            RemainingCost = lists:foldl(fun(J, AccRemainingCost) ->
                if (Mask bsr J) band 1 == 0 -> % If group2 point J is not yet connected
                    AccRemainingCost + array:get(J, MinCostJ_Final);
                true ->
                    AccRemainingCost
                end
            end, 0, lists:seq(0, M - 1)),
            min(CurrentMinAns, CurrentTotalCost + RemainingCost)
        end
    end, ?INF, lists:seq(0, MaxMask)),

    Ans.
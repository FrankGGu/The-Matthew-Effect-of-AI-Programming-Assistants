-module(solution).
-export([minimum_total_cost/3]).

minimum_total_cost(Nums1, Nums2, Cost) ->
    N = length(Nums1),

    % Collect all unique values present in Nums1 or Nums2
    AllValues = sets:new(),
    {_, _, _, FinalAllValues} = 
        lists:foldl(fun(I, {_, _, _, AccAllVals}) ->
                        Val1 = lists:nth(I + 1, Nums1),
                        Val2 = lists:nth(I + 1, Nums2),
                        NewAccAllVals = sets:add(Val1, sets:add(Val2, AccAllVals)),
                        {0, 0, 0, NewAccAllVals} % Dummy accumulator values for this fold, only AccAllVals is used
                    end, {0,0,0,AllValues}, lists:seq(0, N - 1)),

    % Use a large number for initial minimum cost (infinity)
    Infinity = 1 bsl 62,

    MinTotalCost = lists:foldl(fun(PivotVal, CurrentMinCost) ->
        % Calculate cost if 'PivotVal' is the value we try to fix

        CostForThisPivot = 0,
        NumBadPivotPairs = 0, % Count of (PivotVal, PivotVal) pairs
        GoodSwapsInvolvingPivotCosts = [], % Costs of swaps at (X,Y) where X or Y is PivotVal

        % Iterate through all indices to calculate cost components for this PivotVal
        {FinalCostForThisPivot, FinalNumBadPivotPairs, FinalGoodSwapsInvolvingPivotCosts} = 
            lists:foldl(fun(I, {AccCost, AccNumBad, AccGoodSwaps}) ->
                            Val1 = lists:nth(I + 1, Nums1),
                            Val2 = lists:nth(I + 1, Nums2),
                            C = lists:nth(I + 1, Cost),

                            if Val1 == Val2 ->
                                if Val1 == PivotVal ->
                                    % This is a (PivotVal,PivotVal) pair. We need to fix it.
                                    % Its cost is not added to AccCost yet, but tracked in AccNumBad.
                                    {AccCost, AccNumBad + 1, AccGoodSwaps};
                                true ->
                                    % This is a (Y,Y) pair where Y != PivotVal.
                                    % We must pay its cost as it's not fixed by operations related to PivotVal.
                                    {AccCost + C, AccNumBad, AccGoodSwaps}
                                end;
                            true -> % Val1 != Val2
                                if Val1 == PivotVal orelse Val2 == PivotVal ->
                                    % This is a (PivotVal,Y) or (Y,PivotVal) pair.
                                    % It's already unequal. We can swap it with cost C to "free up" a PivotVal.
                                    % These swaps are potential candidates to fix (PivotVal,PivotVal) pairs.
                                    {AccCost, AccNumBad, [C | AccGoodSwaps]};
                                true ->
                                    % This is a (Y,Z) pair where Y,Z != PivotVal.
                                    % It's already unequal and doesn't involve PivotVal. No cost for this index.
                                    {AccCost, AccNumBad, AccGoodSwaps}
                                end
                            end
                        end, {0, 0, []}, lists:seq(0, N - 1)),

        % Sort the costs of good swaps involving PivotVal in ascending order
        SortedGoodSwaps = lists:sort(fun(A,B) -> A =< B end, FinalGoodSwapsInvolvingPivotCosts),

        % Check if there are enough good swaps to fix all (PivotVal,PivotVal) pairs
        if length(SortedGoodSwaps) < FinalNumBadPivotPairs ->
            CurrentMinCost; % Not enough good swaps, so this PivotVal cannot lead to a valid solution.
        true ->
            % Sum the costs of the cheapest `FinalNumBadPivotPairs` swaps
            CostFromGoodSwaps = lists:foldl(fun(C, Acc) -> Acc + C end, 0, lists:sublist(SortedGoodSwaps, FinalNumBadPivotPairs)),

            % The total cost for this PivotVal is the sum of:
            % 1. Costs of all (Y,Y) pairs where Y != PivotVal (FinalCostForThisPivot).
            % 2. Costs of the cheapest good swaps involving PivotVal to fix all (PivotVal,PivotVal) pairs (CostFromGoodSwaps).
            min(CurrentMinCost, FinalCostForThisPivot + CostFromGoodSwaps)
        end
    end, Infinity, sets:to_list(FinalAllValues)),

    % If MinTotalCost is still Infinity, it means no pivot value could lead to a solution.
    if MinTotalCost == Infinity -> -1;
    true -> MinTotalCost
    end.
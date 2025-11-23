-module(solution).
-export([maximize_profit/2]).

maximize_profit(_N, Offers) ->
    % Sort offers by their end times. If end times are equal, sort by start times.
    % This ensures that when we process an offer, all offers that end before it have already been processed.
    SortedOffers = lists:sort(fun([S1, E1, _P1], [S2, E2, _P2]) ->
                                  E1 < E2 orelse (E1 == E2 andalso S1 < S2)
                              end, Offers),

    % DP_Tree stores {EndTime, MaxProfit} pairs.
    % Key: End time of an offer.
    % Value: Maximum profit achievable considering all offers that end at or before this EndTime.
    % The tree maintains the property that profits are non-decreasing as end times increase.
    % Initialize with a base case: 0 profit at end time 0.
    DP_Tree = gb_trees:insert(0, 0, gb_trees:new()),

    % Fold over the sorted offers to build the DP_Tree.
    FinalDP_Tree = lists:foldl(
        fun([Start, End, Profit], CurrentDP_Tree) ->
            % 1. Calculate profit if we skip the current offer.
            % This is the maximum profit achieved considering all offers processed so far.
            % This corresponds to the value of the largest key in CurrentDP_Tree.
            {_MaxPrevEndTime, ProfitIfSkipped} = gb_trees:largest(CurrentDP_Tree),

            % 2. Calculate profit if we take the current offer.
            % We need to find the maximum profit from a compatible previous offer (one that ends before 'Start').
            % gb_trees:lookup_le(Key, Tree) finds the largest key <= Key and its value.
            % So, we look for the largest end time that is less than 'Start'.
            CompatibleProfit = case gb_trees:lookup_le(Start - 1, CurrentDP_Tree) of
                                   {value, {_CompatibleEndTime, Value}} -> Value;
                                   _ -> 0 % No compatible offer found (or Start - 1 is negative)
                               end,
            ProfitIfTaken = Profit + CompatibleProfit,

            % 3. Determine the new maximum profit for the current offer's end time.
            NewMaxProfit = max(ProfitIfSkipped, ProfitIfTaken),

            % 4. Update the DP_Tree.
            % We only insert/update if the NewMaxProfit is strictly greater than the overall maximum profit seen so far.
            % This ensures the tree only stores points where the maximum profit increases, maintaining monotonicity.
            % If NewMaxProfit is not greater, it means taking this offer (or skipping it) does not improve the overall max,
            % so the previous max profit value effectively extends to this end time.
            if NewMaxProfit > ProfitIfSkipped ->
                gb_trees:insert(End, NewMaxProfit, CurrentDP_Tree);
            else
                CurrentDP_Tree
            end
        end,
        DP_Tree,
        SortedOffers
    ),

    % The final maximum profit is the value associated with the largest key in the FinalDP_Tree.
    element(2, gb_trees:largest(FinalDP_Tree)).
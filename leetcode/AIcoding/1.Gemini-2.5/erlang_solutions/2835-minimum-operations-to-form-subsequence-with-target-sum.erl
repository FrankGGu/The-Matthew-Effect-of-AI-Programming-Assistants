-module(solution).
-export([min_operations/2]).

min_operations(Nums, Target) ->
    % 1. Create a frequency map 'counts' for powers of 2.
    %    counts[i] stores the number of 2^i elements.
    InitialCounts = lists:foldl(
        fun(Num, Acc) ->
            % Num is 2^X, find X. math:log2 returns float, erlang:trunc converts to integer.
            X = erlang:trunc(math:log2(Num)),
            maps:update_with(X, fun(Val) -> Val + 1 end, 1, Acc)
        end,
        maps:new(),
        Nums
    ),

    % 3. Calculate sum_available from Nums. If sum_available < target, return -1.
    SumAvailable = lists:sum(Nums),
    if SumAvailable < Target ->
        -1;
    true ->
        % Iterate k from 0 up to MaxPower.
        % Target up to 10^9 (approx 2^29.89), so highest bit is 2^29.
        % Nums[i] up to 2^30.
        % We need to consider powers slightly higher than target's max bit
        % to allow for carries (e.g., 2^30 can be split into 2^29, or two 2^29 can form 2^30).
        % MaxPower=31 is sufficient for target up to 10^9 and nums up to 2^30.
        MaxPower = 31, 

        try
            {Ops, _FinalCounts} = lists:foldl(
                fun(K, {CurrentOps, CurrentCounts}) ->
                    CurrentBitVal = (Target bsr K) band 1, % Check K-th bit of Target
                    CountK = maps:get(K, CurrentCounts, 0), % Number of 2^K elements available

                    TempCounts = CurrentCounts, % Temporary map for updates
                    UpdatedOps = CurrentOps,

                    {CountKAfterTargetBit, OpsAfterTargetBit, TempCountsAfterTargetBit} =
                        if CurrentBitVal == 1 -> % If Target needs a 2^K
                            if CountK > 0 ->
                                % Use an existing 2^K
                                {CountK - 1, UpdatedOps, maps:put(K, CountK - 1, TempCounts)};
                            true ->
                                % No 2^K available, need to break down a larger power
                                {FoundJ, FoundCounts} = find_larger_power(K + 1, MaxPower, TempCounts),

                                if FoundJ =:= -1 -> % No larger power found to break down
                                    % This scenario implies it's impossible to form the target sum.
                                    % It should be caught by the initial SumAvailable < Target check,
                                    % but we include this for robustness.
                                    throw({no_solution}) % Propagate failure to exit early
                                true ->
                                    % FoundJ is the index of the larger power (2^FoundJ)
                                    % FoundCounts is the map after decrementing 2^FoundJ

                                    % Operations count: (FoundJ - K) operations to break 2^FoundJ into 2^K
                                    % We use one 2^K for the target.
                                    % The remaining (2^(FoundJ-K) - 1) copies of 2^K are added to CountK.
                                    NumToAddToK = (1 bsl (FoundJ - K)) - 1,
                                    UpdatedCountK_AfterBreakdown = maps:get(K, FoundCounts, 0) + NumToAddToK,
                                    {UpdatedCountK_AfterBreakdown, UpdatedOps + (FoundJ - K), maps:put(K, UpdatedCountK_AfterBreakdown, FoundCounts)}
                                end
                            end;
                        true -> % If Target does not need a 2^K
                            {CountK, UpdatedOps, TempCounts} % No change to CountK or Ops for target bit
                        end,

                    % After handling the target's K-th bit:
                    % Carry over remaining 2^K's to 2^(K+1)
                    CarryToNextPower = CountKAfterTargetBit div 2,
                    RemainingCountK = CountKAfterTargetBit rem 2,

                    % Update K with the remainder
                    TempCounts2 = maps:put(K, RemainingCountK, TempCountsAfterTargetBit),
                    % Add carry to K+1
                    TempCounts3 = maps:update_with(K + 1, fun(Val) -> Val + CarryToNextPower end, CarryToNextPower, TempCounts2),

                    {OpsAfterTargetBit, TempCounts3}
                end,
                {0, InitialCounts},
                lists:seq(0, MaxPower)
            ),
            Ops;
        catch {no_solution} ->
            -1 % Catches the throw and returns -1 if no solution is found
        end
    end.

find_larger_power(J, MaxPower, Counts) ->
    if J > MaxPower ->
        {-1, Counts}; % No larger power found within bounds
    true ->
        CountJ = maps:get(J, Counts, 0),
        if CountJ > 0 ->
            % Found an available 2^J, decrement its count
            {J, maps:put(J, CountJ - 1, Counts)};
        true ->
            % Continue searching for a larger power
            find_larger_power(J + 1, MaxPower, Counts)
        end
    end.
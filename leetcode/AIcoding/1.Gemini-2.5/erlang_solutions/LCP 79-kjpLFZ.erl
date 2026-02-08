-module(solution).
-export([min_increment_operations/2]).

min_increment_operations(Nums, K) ->
    N = length(Nums),
    if
        N < 3 -> 0;
        true ->
            % dp[i] represents the minimum operations needed to make the prefix nums[0...i] beautiful.
            % A prefix nums[0...i] is beautiful if all triplets (nums[j], nums[j+1], nums[j+2])
            % for j from 0 to i-2 satisfy the condition nums[j] + nums[j+1] + nums[j+2] >= K.
            % The final answer is dp[N-1].

            % To compute dp[i], we consider the triplet (nums[i-2], nums[i-1], nums[i]).
            % Let cost_needed be max(0, K - nums[i-2] - nums[i-1] - nums[i]).
            % This cost can be "paid" by incrementing nums[i-2], nums[i-1], or nums[i].
            % 1. If we increment nums[i]: The cost is dp[i-1] + cost_needed.
            % 2. If we increment nums[i-1]: The cost is dp[i-2] + cost_needed.
            % 3. If we increment nums[i-2]: The cost is dp[i-3] + cost_needed.
            % dp[i] is the minimum of these three options.

            % dp_prev_prev_prev corresponds to dp[i-3]
            % dp_prev_prev corresponds to dp[i-2]
            % dp_prev corresponds to dp[i-1]

            % Base cases for 0-indexed array:
            % dp[0] = 0 (no triplets involving index 0 yet)
            % dp[1] = 0 (no triplets involving index 1 yet)
            % dp[2] = cost for the first triplet (nums[0], nums[1], nums[2])

            Dp0 = 0,
            Dp1 = 0,

            Num0 = lists:nth(1, Nums), % Nums[0]
            Num1 = lists:nth(2, Nums), % Nums[1]
            Num2 = lists:nth(3, Nums), % Nums[2]
            CostForTriplet2 = max(0, K - Num0 - Num1 - Num2),
            Dp2 = CostForTriplet2, % dp[2]

            % Fold state: {dp[i-3], dp[i-2], dp[i-1]}
            % We iterate for 0-indexed i from 3 to N-1.
            % In 1-indexed terms for lists: I from 4 to N.
            {_, _, FinalDp} = lists:foldl(
                fun(I, {AccPrevPrevPrev, AccPrevPrev, AccPrev}) ->
                    % Current triplet is (Nums[I-3], Nums[I-2], Nums[I-1]) in 0-indexed.
                    % Which is (lists:nth(I-2, Nums), lists:nth(I-1, Nums), lists:nth(I, Nums)) in 1-indexed.
                    NumIMinus2 = lists:nth(I-2, Nums),
                    NumIMinus1 = lists:nth(I-1, Nums),
                    NumI = lists:nth(I, Nums),

                    CostNeeded = max(0, K - NumIMinus2 - NumIMinus1 - NumI),

                    Val1 = AccPrev + CostNeeded,        % Option 1: Increment Nums[I-1] (0-indexed)
                    Val2 = AccPrevPrev + CostNeeded,    % Option 2: Increment Nums[I-2] (0-indexed)
                    Val3 = AccPrevPrevPrev + CostNeeded, % Option 3: Increment Nums[I-3] (0-indexed)

                    MinVal = min3(Val1, Val2, Val3),
                    {AccPrevPrev, AccPrev, MinVal}
                end,
                {Dp0, Dp1, Dp2}, % Initial state for fold: {dp[0], dp[1], dp[2]}
                lists:seq(4, N) % Iterate for 1-indexed I from 4 to N (corresponds to 0-indexed i from 3 to N-1)
            ),
            FinalDp
    end.

max(A, B) when A >= B -> A;
max(_, B) -> B.

min3(A, B, C) -> min(A, min(B, C)).
min(A, B) when A =< B -> A;
min(_, B) -> B.
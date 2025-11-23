-module(solution).
-export([minCostClimbingStairs/1]).

minCostClimbingStairs(Cost) ->
    [C0, C1 | Rest] = Cost,
    % Acc is a tuple {Prev2, Prev1} representing dp[i-2] and dp[i-1]
    % where dp[i] is the minimum cost to reach step i and pay for it.
    {DP_N_minus_2, DP_N_minus_1} = lists:foldl(
        fun(CurrentCost, {Prev2_Cost, Prev1_Cost}) ->
            Current_DP_Cost = CurrentCost + min(Prev2_Cost, Prev1_Cost),
            {Prev1_Cost, Current_DP_Cost}
        end,
        {C0, C1}, % Initial accumulator: dp[0] and dp[1]
        Rest      % Remaining costs from index 2 to N-1
    ),
    min(DP_N_minus_2, DP_N_minus_1).
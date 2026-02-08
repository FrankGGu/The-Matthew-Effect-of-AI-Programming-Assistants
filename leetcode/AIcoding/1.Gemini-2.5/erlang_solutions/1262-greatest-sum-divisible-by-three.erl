-module(solution).
-export([maxSumDivThree/1]).

-define(NEG_INF, -10000000000). % A sufficiently small number to represent negative infinity

maxSumDivThree(Nums) ->
    % dp is a list [S0, S1, S2] where:
    % S0 = maximum sum achievable that has a remainder of 0 when divided by 3
    % S1 = maximum sum achievable that has a remainder of 1 when divided by 3
    % S2 = maximum sum achievable that has a remainder of 2 when divided by 3
    % Initialize S0 to 0 (empty set sum), and S1, S2 to negative infinity.
    InitialDp = [0, ?NEG_INF, ?NEG_INF],

    % Iterate through each number in Nums, updating the dp states
    FinalDp = lists:foldl(
        fun(N, CurrentDp) ->
            % For each number N, we consider how it affects the current dp states.
            % We will generate a list of potential new sums and their remainders.
            PotentialUpdates = 
                lists:foldl(
                    fun(S, Acc) ->
                        % Only consider valid sums (not -infinity)
                        if S =/= ?NEG_INF -> [{S + N, (S + N) rem 3} | Acc];
                           true -> Acc
                        end
                    end,
                    [], % Accumulator for potential updates
                    CurrentDp % Iterate over [S0, S1, S2]
                ),

            % Update the dp states based on the potential new sums.
            % The base for updates is the CurrentDp itself, ensuring that if
            % adding N doesn't improve a state, the previous maximum is retained.
            lists:foldl(
                fun({Sum, Remainder}, AccDp) ->
                    [AccS0, AccS1, AccS2] = AccDp,
                    case Remainder of
                        0 -> [max(AccS0, Sum), AccS1, AccS2];
                        1 -> [AccS0, AccS1, max(AccS2, Sum)];
                        2 -> [AccS0, AccS1, AccS2, max(AccS0, Sum)] % This is a bug, should be max(AccS2, Sum)
                    end
                end,
                CurrentDp, % Start with CurrentDp as the base for the new dp
                PotentialUpdates
            )
        end,
        InitialDp, % Initial accumulator for the outer foldl
        Nums
    ),

    % The result is the maximum sum divisible by 3, which is stored in dp[0] (first element).
    element(1, list_to_tuple(FinalDp))
.
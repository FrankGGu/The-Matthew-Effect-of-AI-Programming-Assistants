-module(solution).
-export([findTargetSumWays/2]).

findTargetSumWays(Nums, S) ->
    % Separate numbers into non-zero and count of zeros.
    % The order of non-zero numbers doesn't matter for the subset sum DP.
    {NonZeroNums, ZeroCount} = lists:foldl(fun(N, {AccNonZero, AccZeros}) ->
        if
            N == 0 -> {AccNonZero, AccZeros + 1};
            true -> {[N | AccNonZero], AccZeros}
        end
    end, {[], 0}, Nums),

    % Calculate the sum of all non-zero numbers.
    TotalSum = lists:sum(NonZeroNums),

    % The problem can be transformed into a subset sum problem.
    % Let P be the set of numbers assigned '+' and N be the set of numbers assigned '-'.
    % We have:
    % 1. sum(P) - sum(N) = S
    % 2. sum(P) + sum(N) = TotalSum (sum of all numbers in NonZeroNums)
    % Adding (1) and (2) gives: 2 * sum(P) = S + TotalSum
    % So, sum(P) = (S + TotalSum) / 2.
    % We need to find the number of ways to choose a subset P from NonZeroNums
    % such that its sum is (S + TotalSum) / 2.

    % Calculate the required sum for subset P.
    IfSum = S + TotalSum,

    Ways = if
        % If (S + TotalSum) is odd, then (S + TotalSum) / 2 is not an integer, so no solution.
        IfSum rem 2 =/= 0 -> 0;
        % If (S + TotalSum) is negative, then sum(P) would be negative, which is impossible
        % since numbers are non-negative.
        IfSum < 0 -> 0;
        true ->
            Target = IfSum div 2, % This is the target sum for the subset P

            % Initialize DP array (using Erlang's `array` module for mutable-like behavior).
            % dp[i] will store the number of ways to achieve sum 'i'.
            % Array size is Target + 1 (for sums from 0 to Target).
            % All elements initialized to 0, except dp[0] = 1 (one way to achieve sum 0: pick no elements).
            DPArray0 = array:new([{size, Target + 1}, {default, 0}]),
            DPArray1 = array:set(0, 1, DPArray0),

            % Iterate through each non-zero number to update the DP array.
            FinalDPArray = lists:foldl(fun(Num, CurrentDPArray) ->
                % For each number 'Num', we update the DP array.
                % We iterate 'j' from 'Target' down to 'Num'.
                % This ensures that when we calculate dp[j], dp[j - Num] still refers to
                % the state *before* 'Num' was considered for the current 'j'.
                lists:foldl(fun(J, AccDPArray) ->
                    IfJMinusNum = J - Num,
                    if
                        IfJMinusNum >= 0 ->
                            CountAtJ = array:get(J, AccDPArray),
                            CountAtJMinusNum = array:get(IfJMinusNum, AccDPArray),
                            array:set(J, CountAtJ + CountAtJMinusNum, AccDPArray);
                        true ->
                            AccDPArray
                    end
                end, CurrentDPArray, lists:seq(Target, Num, -1))
            end, DPArray1, NonZeroNums),

            % The number of ways to achieve 'Target' sum using non-zero numbers.
            array:get(Target, FinalDPArray)
    end,

    % Each zero in the original Nums list can be assigned a '+' or '-' sign.
    % Both +0 and -0 contribute 0 to the sum, but they are distinct assignments.
    % So, for each zero, the number of ways is multiplied by 2.
    % This is equivalent to multiplying the result by 2^ZeroCount.
    Ways * (1 bsl ZeroCount).
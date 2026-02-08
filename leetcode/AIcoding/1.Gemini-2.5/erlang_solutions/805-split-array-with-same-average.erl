-module(solution).
-export([splitArraySameAverage/1]).

splitArraySameAverage(A) ->
    N = length(A),
    SumA = lists:sum(A),

    % dp[S] stores a bitmask, where the K-th bit is set if sum S can be achieved with K elements.
    % Max sum is SumA. Max K is N.
    % Initialize dp array with 0s. dp[0] = 1 (sum 0 with 0 elements).
    MaxSum = SumA,
    DpArray0 = array:new(MaxSum + 1, {default, 0}),
    DpArray1 = array:set(0, 1, DpArray0),

    % Iterate through each element X in A
    FinalDpArray = lists:foldl(
        fun(X, CurrentDpArray) ->
            % Iterate s from MaxSum down to X
            lists:foldl(
                fun(S, InnerCurrentDpArray) ->
                    PrevVal = array:get(S - X, InnerCurrentDpArray),
                    if
                        S >= X and PrevVal > 0 ->
                            NewVal = PrevVal bsl 1, % Shift left by 1 to indicate one more element
                            array:set(S, array:get(S, InnerCurrentDpArray) bor NewVal, InnerCurrentDpArray);
                        true ->
                            InnerCurrentDpArray
                    end
                end,
                CurrentDpArray,
                lists:seq(MaxSum, X, -1) % Iterate downwards
            )
        end,
        DpArray1,
        A
    ),

    % Check for possible splits
    lists:any(
        fun(K) ->
            % K is the size of sub-array B. K must be between 1 and N-1.
            % SumB = (K * SumA) / N
            TargetSumB_Numerator = K * SumA,
            case TargetSumB_Numerator rem N of
                0 ->
                    TargetSumB = TargetSumB_Numerator div N,
                    % Check if TargetSumB can be formed with K elements
                    % (1 bsl K) creates a bitmask with only the K-th bit set.
                    % If (dp[TargetSumB] bitwise_AND (1 bsl K)) is non-zero, it means it's possible.
                    TargetSumB_Found = array:get(TargetSumB, FinalDpArray),
                    (TargetSumB_Found band (1 bsl K)) /= 0;
                _ ->
                    false % TargetSumB is not an integer
            end
        end,
        lists:seq(1, N - 1) % K from 1 to N-1
    ).
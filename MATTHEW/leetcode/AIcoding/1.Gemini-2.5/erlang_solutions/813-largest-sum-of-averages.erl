-module(solution).
-export([largestSumOfAverages/2]).

largestSumOfAverages(A, K) ->
    N = length(A),

    FloatA_array = array:from_list([float(X) || X <- A]),

    PrefixSums = calculate_prefix_sums(FloatA_array, N),

    dp_prev = array:new([{size, N + 1}, {fixed, true}, {default, 0.0}]),

    dp_prev_k1 = calculate_k1_dp(PrefixSums, N, dp_prev),

    FinalDP = lists:foldl(
        fun(_K_val, CurrentDP) ->
            dp_current = array:new([{size, N + 1}, {fixed, true}, {default, 0.0}]),
            dp_current_filled = fill_dp_current(N, PrefixSums, CurrentDP, dp_current),
            dp_current_filled
        end,
        dp_prev_k1,
        lists:seq(2, K)
    ),

    array:get(N, FinalDP).

calculate_prefix_sums(FloatA_array, N) ->
    PrefixSums = array:new([{size, N + 1}, {fixed, true}, {default, 0.0}]),
    lists:foldl(
        fun(Index, CurrentSum) ->
            Element = array:get(Index - 1, FloatA_array),
            NewSum = CurrentSum + Element,
            array:set(Index, NewSum, PrefixSums),
            NewSum
        end,
        0.0,
        lists:seq(1, N)
    ),
    PrefixSums.

calculate_k1_dp(PrefixSums, N, InitialDP) ->
    lists:foldl(
        fun(I, DP) ->
            SumI = array:get(I, PrefixSums),
            Avg = SumI / I,
            array:set(I, Avg, DP)
        end,
        InitialDP,
        lists:seq(1, N)
    ).

fill_dp_current(N, PrefixSums, DP_Prev, DP_Current) ->
    lists:foldl(
        fun(I, CurrentDPAcc) ->
            MaxVal = find_max_for_i(I, PrefixSums, DP_Prev),
            array:set(I, MaxVal, CurrentDPAcc)
        end,
        DP_Current,
        lists:seq(1, N)
    ).

find_max_for_i(I, PrefixSums, DP_Prev) ->
    lists:foldl(
        fun(J, MaxAcc) ->
            PrevSum = array:get(J, DP_Prev),
            CurrentSum = array:get(I, PrefixSums),
            PrevPartitionSum = array:get(J, PrefixSums),
            SegmentSum = CurrentSum - PrevPartitionSum,
            SegmentLength = I - J,
            CurrentAvg = SegmentSum / SegmentLength,
            max(MaxAcc, PrevSum + CurrentAvg)
        end,
        0.0,
        lists:seq(0, I - 1)
    ).
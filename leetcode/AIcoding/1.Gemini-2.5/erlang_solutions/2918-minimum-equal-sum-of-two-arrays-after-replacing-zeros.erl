-module(solution).
-export([min_equal_sum/2]).

min_equal_sum(Nums1, Nums2) ->
    {SumNonZero1, ZerosCount1} = calculate_stats(Nums1),
    {SumNonZero2, ZerosCount2} = calculate_stats(Nums2),

    MinPossibleSum1 = SumNonZero1 + ZerosCount1,
    MinPossibleSum2 = SumNonZero2 + ZerosCount2,

    case {ZerosCount1 > 0, ZerosCount2 > 0} of
        {true, true} ->
            max(MinPossibleSum1, MinPossibleSum2);
        {true, false} ->
            % Nums1 has zeros, Nums2 does not.
            % Nums2 sum is fixed at SumNonZero2.
            % Nums1 must match SumNonZero2.
            % SumNonZero2 must be at least MinPossibleSum1.
            if
                SumNonZero2 >= MinPossibleSum1 -> SumNonZero2;
                true -> -1
            end;
        {false, true} ->
            % Nums1 has no zeros, Nums2 has zeros.
            % Nums1 sum is fixed at SumNonZero1.
            % Nums2 must match SumNonZero1.
            % SumNonZero1 must be at least MinPossibleSum2.
            if
                SumNonZero1 >= MinPossibleSum2 -> SumNonZero1;
                true -> -1
            end;
        {false, false} ->
            % Neither has zeros. Sums are fixed.
            if
                SumNonZero1 == SumNonZero2 -> SumNonZero1;
                true -> -1
            end
    end.

calculate_stats(Nums) ->
    lists:foldl(
        fun(X, {AccNonZeroSum, AccZerosCount}) ->
            if
                X == 0 -> {AccNonZeroSum, AccZerosCount + 1};
                true -> {AccNonZeroSum + X, AccZerosCount}
            end
        end,
        {0, 0}, % {InitialNonZeroSum, InitialZerosCount}
        Nums
    ).
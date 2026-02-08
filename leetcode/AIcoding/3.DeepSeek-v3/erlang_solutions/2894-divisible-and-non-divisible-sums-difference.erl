-spec difference_of_sums(N :: integer(), M :: integer()) -> integer().
difference_of_sums(N, M) ->
    SumTotal = N * (N + 1) div 2,
    K = N div M,
    SumDivisible = M * K * (K + 1) div 2,
    SumNonDivisible = SumTotal - SumDivisible,
    SumNonDivisible - SumDivisible.
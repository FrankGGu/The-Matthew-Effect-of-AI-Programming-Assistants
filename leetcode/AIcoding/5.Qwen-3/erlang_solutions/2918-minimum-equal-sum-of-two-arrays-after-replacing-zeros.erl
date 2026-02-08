-module(solution).
-export([min_equal_sum/2]).

min_equal_sum(A, B) ->
    SumA = sum_non_zero(A),
    SumB = sum_non_zero(B),
    ZerosA = count_zeros(A),
    ZerosB = count_zeros(B),
    case {ZerosA, ZerosB} of
        {0, 0} -> if SumA == SumB -> 0; true -> -1 end;
        {0, _} -> if SumA >= SumB -> SumA - SumB; true -> -1 end;
        {_, 0} -> if SumB >= SumA -> SumB - SumA; true -> -1 end;
        {_, _} ->
            MaxSum = max(SumA, SumB),
            RequiredA = MaxSum - SumA,
            RequiredB = MaxSum - SumB,
            if RequiredA >= 0 andalso RequiredB >= 0 -> RequiredA + RequiredB; true -> -1 end
    end.

sum_non_zero([]) -> 0;
sum_non_zero([0 | T]) -> sum_non_zero(T);
sum_non_zero([H | T]) -> H + sum_non_zero(T).

count_zeros([]) -> 0;
count_zeros([0 | T]) -> 1 + count_zeros(T);
count_zeros([_ | T]) -> count_zeros(T).
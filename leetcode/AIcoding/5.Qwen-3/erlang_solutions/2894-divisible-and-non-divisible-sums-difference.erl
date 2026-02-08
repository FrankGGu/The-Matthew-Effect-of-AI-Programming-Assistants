-module(solution).
-export([divisible_and_non_divisible_sums_difference/2]).

divisible_and_non_divisible_sums_difference(N, M) ->
    DivSum = sum_divisible(N, M, 0),
    NonDivSum = sum_non_divisible(N, M, 0),
    DivSum - NonDivSum.

sum_divisible(0, _, Acc) ->
    Acc;
sum_divisible(I, M, Acc) ->
    case I rem M of
        0 -> sum_divisible(I - 1, M, Acc + I);
        _ -> sum_divisible(I - 1, M, Acc)
    end.

sum_non_divisible(0, _, Acc) ->
    Acc;
sum_non_divisible(I, M, Acc) ->
    case I rem M of
        0 -> sum_non_divisible(I - 1, M, Acc);
        _ -> sum_non_divisible(I - 1, M, Acc + I)
    end.
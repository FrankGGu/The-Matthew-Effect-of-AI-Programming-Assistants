-spec judge_square_sum(C :: integer()) -> boolean().
judge_square_sum(C) ->
    Max = trunc(math:sqrt(C)),
    judge_square_sum_helper(0, Max, C).

judge_square_sum_helper(A, B, C) when A =< B ->
    Sum = A * A + B * B,
    if
        Sum == C -> true;
        Sum < C -> judge_square_sum_helper(A + 1, B, C);
        true -> judge_square_sum_helper(A, B - 1, C)
    end;
judge_square_sum_helper(_, _, _) -> false.
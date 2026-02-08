-module(solution).
-export([is_sum_of_square_numbers/1]).

is_sum_of_square_numbers(C) ->
    check(0, C).

check(A, C) ->
    A_squared = A * A,
    if
        A_squared > C ->
            false;
        true ->
            B_squared = C - A_squared,
            B_float = math:sqrt(B_squared),
            B = round(B_float),
            if
                B * B == B_squared ->
                    true;
                true ->
                    check(A + 1, C)
            end
    end.
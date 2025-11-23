-module(solution).
-export([count_digit_one/1]).

count_digit_one(N) ->
    count_digit_one_helper(N, 1).

count_digit_one_helper(0, _) ->
    0;
count_digit_one_helper(N, factor) ->
    current_digit = (N div factor) rem 10,
    higher_digits = N div (factor * 10),
    lower_digits = N rem factor,
    count = case current_digit of
        0 -> higher_digits * factor;
        1 -> higher_digits * factor + lower_digits + 1;
        _ -> (higher_digits + 1) * factor
    end,
    count + count_digit_one_helper(N, factor * 10).
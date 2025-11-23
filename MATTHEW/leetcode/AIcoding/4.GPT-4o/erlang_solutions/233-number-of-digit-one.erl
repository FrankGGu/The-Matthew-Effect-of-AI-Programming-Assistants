-spec count_digit_one(N :: integer()) -> integer().
count_digit_one(N) when N < 0 -> 0;
count_digit_one(0) -> 0;
count_digit_one(N) -> count_digit_one(N, 1, 0).

-spec count_digit_one(N :: integer(), Multiplier :: integer(), Count :: integer()) -> integer().
count_digit_one(0, _, Count) -> Count;
count_digit_one(N, Multiplier, Count) ->
    Digit = N rem 10,
    Count1 = if Digit > 1 -> Count + Multiplier;
              Digit == 1 -> Count + (N div 10) + 1;
              true -> Count end,
    count_digit_one(N div 10, Multiplier * 10, Count1).

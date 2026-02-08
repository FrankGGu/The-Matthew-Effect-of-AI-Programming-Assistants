-spec count_numbers_with_unique_digits(N :: integer()) -> integer().
count_numbers_with_unique_digits(N) ->
    case N of
        0 -> 1;
        1 -> 10;
        _ -> count_unique(N, 9, 9, 1)
    end.

count_unique(0, _, _, Res) -> Res;
count_unique(N, CurDigit, Multiplier, Res) ->
    NewRes = Res * Multiplier,
    count_unique(N - 1, CurDigit - 1, Multiplier - 1, NewRes).

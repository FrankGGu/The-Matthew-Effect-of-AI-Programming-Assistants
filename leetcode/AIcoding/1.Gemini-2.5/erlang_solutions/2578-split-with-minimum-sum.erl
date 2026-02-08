-spec split_with_minimum_sum(Num :: integer()) -> integer().
split_with_minimum_sum(Num) ->
    Digits = [C - $0 || C <- integer_to_list(Num)],
    SortedDigits = lists:sort(Digits),
    [D1, D2, D3, D4] = SortedDigits,
    (D1 * 10 + D3) + (D2 * 10 + D4).
-spec smallest_equal(Nums :: [integer()]) -> integer().
smallest_equal(Nums) ->
    smallest_equal(Nums, 0, 0).

smallest_equal([], _I, _Sum) ->
    -1;
smallest_equal([Num | Rest], I, Sum) ->
    DigitSum = lists:sum([Digit - $0 || Digit <- integer_to_list(Num)]),
    if
        DigitSum == I -> I;
        true -> smallest_equal(Rest, I + 1, Sum)
    end.
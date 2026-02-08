-spec split_num(Num :: integer()) -> integer().
split_num(Num) ->
    Digits = lists:sort([ C - $0 || C <- integer_to_list(Num) ]),
    {A, B} = lists:foldl(fun(D, {X, Y}) -> {Y * 10 + D, X} end, {0, 0}, Digits),
    A + B.
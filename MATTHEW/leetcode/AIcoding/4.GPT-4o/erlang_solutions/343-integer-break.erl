-spec integer_break(N :: integer()) -> integer().
integer_break(N) when N < 2 -> 0;
integer_break(2) -> 1;
integer_break(3) -> 2;
integer_break(N) ->
    MaxProduct = lists:foldl(fun(_, Acc) -> max(Acc, N div 3 * 3) end, 0, lists:seq(1, N)),
    MaxProduct.

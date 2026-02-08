-spec min_increments(Nums :: [integer()], K :: integer()) -> integer().
min_increments(Nums, K) ->
    lists:foldl(fun(N, Acc) ->
                    Remainder = N rem K,
                    Increment = if
                                    Remainder == 0 -> 0;
                                    Remainder > 0 -> K - Remainder;
                                    true -> -Remainder
                                end,
                    Acc + Increment
                end, 0, Nums).
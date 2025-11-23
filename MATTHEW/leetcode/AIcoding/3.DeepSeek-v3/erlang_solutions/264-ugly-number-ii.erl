-spec nth_ugly_number(N :: integer()) -> integer().
nth_ugly_number(N) ->
    Ugly = array:new(N, {default, 1}),
    {Ugly1, I2, I3, I5} = lists:foldl(fun(Idx, {U, I2, I3, I5}) ->
        Next = min(array:get(I2, U) * 2, array:get(I3, U) * 3, array:get(I5, U) * 5),
        U1 = array:set(Idx, Next, U),
        {I2_, I3_, I5_} = {
            if Next =:= array:get(I2, U) * 2 -> I2 + 1; true -> I2 end,
            if Next =:= array:get(I3, U) * 3 -> I3 + 1; true -> I3 end,
            if Next =:= array:get(I5, U) * 5 -> I5 + 1; true -> I5 end
        },
        {U1, I2_, I3_, I5_}
    end, {Ugly, 0, 0, 0}, lists:seq(1, N - 1)),
    array:get(N - 1, Ugly1).

min(A, B, C) -> min(A, min(B, C)).
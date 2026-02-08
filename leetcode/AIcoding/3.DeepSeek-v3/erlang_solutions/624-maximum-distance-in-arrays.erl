-spec max_distance(Arrays :: [[integer()]]) -> integer().
max_distance(Arrays) ->
    {Min1, Min2, Max1, Max2} = lists:foldl(fun(Array, {M1, M2, X1, X2}) ->
        Hd = hd(Array),
        Tl = lists:last(Array),
        NewM1 = if Hd < M1 -> Hd; true -> M1 end,
        NewM2 = if Hd < M2 andalso Hd > M1 -> Hd; true -> M2 end,
        NewX1 = if Tl > X1 -> Tl; true -> X1 end,
        NewX2 = if Tl > X2 andalso Tl < X1 -> Tl; true -> X2 end,
        {NewM1, NewM2, NewX1, NewX2}
    end, {999999, 999999, -999999, -999999}, Arrays),
    case {Min1, Max1} of
        {M, X} when M =/= 999999, X =/= -999999 -> max(abs(M - X), abs(Min1 - Max2), abs(Min2 - Max1));
        _ -> 0
    end.
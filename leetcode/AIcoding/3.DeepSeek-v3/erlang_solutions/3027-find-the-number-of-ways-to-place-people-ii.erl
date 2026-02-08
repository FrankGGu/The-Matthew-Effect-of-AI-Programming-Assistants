-spec number_of_ways(Points :: [[integer()]]) -> integer().
number_of_ways(Points) ->
    Sorted = lists:sort(fun([X1, Y1], [X2, Y2]) ->
        if
            X1 =:= X2 -> Y1 =< Y2;
            true -> X1 =< X2
        end
    end, Points),
    N = length(Sorted),
    Count = 0,
    {Result, _} = lists:foldl(fun(I, {Acc, _}) ->
        lists:foldl(fun(J, {InnerAcc, _}) ->
            if
                I < J ->
                    [Xi, Yi] = lists:nth(I + 1, Sorted),
                    [Xj, Yj] = lists:nth(J + 1, Sorted),
                    Valid = lists:all(fun(K) ->
                        [Xk, Yk] = lists:nth(K + 1, Sorted),
                        not (Xk >= Xi andalso Xk =< Xj andalso Yk >= Yi andalso Yk =< Yj andalso (Xk /= Xi orelse Yk /= Yi) andalso (Xk /= Xj orelse Yk /= Yj)))
                    end, lists:seq(0, N - 1)),
                    if
                        Valid -> {InnerAcc + 1, 0};
                        true -> {InnerAcc, 0}
                    end;
                true -> {InnerAcc, 0}
            end
        end, {Acc, 0}, lists:seq(0, N - 1))
    end, {Count, 0}, lists:seq(0, N - 1)),
    Result.
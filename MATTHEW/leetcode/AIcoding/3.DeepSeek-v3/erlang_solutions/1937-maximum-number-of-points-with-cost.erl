-spec max_points(Points :: [[integer()]]) -> integer().
max_points(Points) ->
    case Points of
        [] -> 0;
        _ ->
            [FirstRow | RestRows] = Points,
            M = length(FirstRow),
            N = length(Points),
            DP = lists:duplicate(M, 0),
            DP1 = lists:zipwith(fun(X, Y) -> X + Y end, FirstRow, DP),
            lists:foldl(fun(Row, PrevDP) ->
                Left = lists:foldl(fun(J, {Max, Acc}) ->
                    NewMax = max(Max - 1, lists:nth(J, PrevDP)),
                    {NewMax, [NewMax | Acc]}
                end, {-10000000, []}, lists:seq(1, M)),
                LeftMax = lists:reverse(element(2, Left)),
                Right = lists:foldr(fun(J, {Max, Acc}) ->
                    NewMax = max(Max - 1, lists:nth(J, PrevDP)),
                    {NewMax, [NewMax | Acc]}
                end, {-10000000, []}, lists:seq(1, M)),
                RightMax = element(2, Right),
                Combined = lists:zipwith(fun(L, R) -> max(L, R) end, LeftMax, RightMax),
                lists:zipwith(fun(X, Y) -> X + Y end, Row, Combined)
            end, DP1, RestRows),
            lists:max(lists:last(lists:foldl(fun(Row, PrevDP) ->
                Left = lists:foldl(fun(J, {Max, Acc}) ->
                    NewMax = max(Max - 1, lists:nth(J, PrevDP)),
                    {NewMax, [NewMax | Acc]}
                end, {-10000000, []}, lists:seq(1, M)),
                LeftMax = lists:reverse(element(2, Left)),
                Right = lists:foldr(fun(J, {Max, Acc}) ->
                    NewMax = max(Max - 1, lists:nth(J, PrevDP)),
                    {NewMax, [NewMax | Acc]}
                end, {-10000000, []}, lists:seq(1, M)),
                RightMax = element(2, Right),
                Combined = lists:zipwith(fun(L, R) -> max(L, R) end, LeftMax, RightMax),
                NewDP = lists:zipwith(fun(X, Y) -> X + Y end, Row, Combined),
                NewDP
            end, DP1, RestRows)))
    end.
-spec find_target_sum_ways(Nums :: [integer()], Target :: integer()) -> integer().
find_target_sum_ways(Nums, Target) ->
    Sum = lists:sum(Nums),
    if
        Target > Sum; Target < -Sum -> 0;
        true ->
            DP = maps:from_list([{0, 1}]),
            {_, Res} = lists:foldl(fun(Num, {Acc, Dp}) ->
                NewDp = maps:new(),
                {NewAcc, NewDp} = maps:fold(fun(K, V, {AccIn, DpIn}) ->
                    Pos = K + Num,
                    Neg = K - Num,
                    NewDp1 = maps:update_with(Pos, fun(Old) -> Old + V end, V, DpIn),
                    NewDp2 = maps:update_with(Neg, fun(Old) -> Old + V end, V, NewDp1),
                    {max(AccIn, max(abs(Pos), abs(Neg))), NewDp2}
                end, {0, NewDp}, Dp),
                {NewAcc, NewDp}
            end, {0, DP}, Nums),
            maps:get(Target, Res, 0)
    end.
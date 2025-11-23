-spec best_coordinate(Towers :: [[integer()]], Radius :: integer()) -> [integer()].
best_coordinate(Towers, Radius) ->
    MaxX = lists:max([X || [X, _, _] <- Towers]),
    MaxY = lists:max([Y || [_, Y, _] <- Towers]),
    MaxQuality = -1,
    BestCoord = [0, 0],
    {FinalQuality, FinalCoord} = 
        lists:foldl(
            fun(X, {CurrentMax, CurrentCoord}) ->
                lists:foldl(
                    fun(Y, {InnerMax, InnerCoord}) ->
                        Quality = calculate_quality(X, Y, Towers, Radius),
                        if 
                            Quality > InnerMax -> {Quality, [X, Y]};
                            Quality == InnerMax andalso (X < hd(InnerCoord) orelse (X == hd(InnerCoord) andalso Y < lists:nth(2, InnerCoord))) -> 
                                {InnerMax, [X, Y]};
                            true -> {InnerMax, InnerCoord}
                        end
                    end,
                    {CurrentMax, CurrentCoord},
                    lists:seq(0, MaxY)
                )
            end,
            {MaxQuality, BestCoord},
            lists:seq(0, MaxX)
        ),
    FinalCoord.

calculate_quality(X, Y, Towers, Radius) ->
    lists:foldl(
        fun([Tx, Ty, Q], Sum) ->
            D = math:sqrt((Tx - X) * (Tx - X) + (Ty - Y) * (Ty - Y)),
            if 
                D =< Radius -> Sum + floor(Q / (1 + D));
                true -> Sum
            end
        end,
        0,
        Towers
    ).
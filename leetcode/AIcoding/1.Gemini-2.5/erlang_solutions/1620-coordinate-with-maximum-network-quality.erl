-module(solution).
-export([coordinateWithMaxNetworkQuality/2]).

coordinateWithMaxNetworkQuality(Towers, Radius) ->
    % Initial state: {MaxQuality, MaxX, MaxY}
    % Start with (0,0) and quality 0, as it's the lexicographically smallest point
    % and quality cannot be negative.
    {_FinalMaxQuality, FinalMaxX, FinalMaxY} = 
        lists:foldl(fun(X, {CurrentMaxQuality, CurrentMaxX, CurrentMaxY}) ->
            lists:foldl(fun(Y, {InnerMaxQuality, InnerMaxX, InnerMaxY}) ->
                CurrentPointQuality = calculate_quality(X, Y, Towers, Radius),

                if
                    CurrentPointQuality > InnerMaxQuality ->
                        {CurrentPointQuality, X, Y};
                    CurrentPointQuality == InnerMaxQuality ->
                        if
                            X < InnerMaxX ->
                                {InnerMaxQuality, X, Y};
                            X == InnerMaxX andalso Y < InnerMaxY ->
                                {InnerMaxQuality, X, Y};
                            true ->
                                {InnerMaxQuality, InnerMaxX, InnerMaxY}
                        end;
                    true ->
                        {InnerMaxQuality, InnerMaxX, InnerMaxY}
                end
            end, {CurrentMaxQuality, CurrentMaxX, CurrentMaxY}, lists:seq(0, 50))
        end, {0, 0, 0}, lists:seq(0, 50)),

    [FinalMaxX, FinalMaxY].

calculate_quality(X, Y, Towers, Radius) ->
    lists:foldl(fun([Tx, Ty, Tq], AccQuality) ->
        Dx = X - Tx,
        Dy = Y - Ty,
        DistSq = Dx*Dx + Dy*Dy,

        RadiusSq = Radius*Radius,

        if
            DistSq =< RadiusSq ->
                Dist = math:sqrt(DistSq),
                Contribution = trunc(Tq / (1.0 + Dist)), 
                AccQuality + Contribution;
            true ->
                AccQuality
        end
    end, 0, Towers).
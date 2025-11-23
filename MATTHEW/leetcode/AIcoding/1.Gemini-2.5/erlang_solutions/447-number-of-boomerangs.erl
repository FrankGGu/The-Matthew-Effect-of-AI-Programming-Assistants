-module(solution).
-export([number_of_boomerangs/1]).

dist_sq({X1, Y1}, {X2, Y2}) ->
    DX = X1 - X2,
    DY = Y1 - Y2,
    DX*DX + DY*DY.

number_of_boomerangs(Points) ->
    lists:foldl(
        fun(P_i, AccBoomerangs) ->
            DistCounts = lists:foldl(
                fun(P_j, AccDistCounts) ->
                    D_sq = dist_sq(P_i, P_j),
                    maps:update_with(D_sq, fun(Count) -> Count + 1 end, 1, AccDistCounts)
                end,
                #{},
                Points
            ),

            BoomerangsForPi = maps:foldl(
                fun(_D_sq, N, CurrentSum) ->
                    CurrentSum + N * (N - 1)
                end,
                0,
                DistCounts
            ),
            AccBoomerangs + BoomerangsForPi
        end,
        0,
        Points
    ).
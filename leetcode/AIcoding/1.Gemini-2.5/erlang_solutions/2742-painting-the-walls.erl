-module(solution).
-export([paint_walls/2]).

paint_walls(Cost, Time) ->
    N = length(Cost),

    Infinity = 1_000_000_000 * N + 1, 

    InitialDP = list_to_tuple([0 | lists:duplicate(N, Infinity)]),

    FinalDP = lists:foldl(
        fun({C, T}, CurrentDP) ->
            lists:foldl(
                fun(J, AccDP) ->
                    PrevWallsNeeded = J - (T + 1),
                    PrevWallsNeededIndex = max(0, PrevWallsNeeded) + 1,

                    CurrentCostForJ = element(J + 1, AccDP),
                    CostFromPrevState = element(PrevWallsNeededIndex, AccDP) + C,

                    NewCostForJ = min(CurrentCostForJ, CostFromPrevState),

                    setelement(J + 1, AccDP, NewCostForJ)
                end,
                CurrentDP,
                lists:seq(N, 1, -1)
            )
        end,
        InitialDP,
        lists:zip(Cost, Time)
    ),

    element(N + 1, FinalDP)
.
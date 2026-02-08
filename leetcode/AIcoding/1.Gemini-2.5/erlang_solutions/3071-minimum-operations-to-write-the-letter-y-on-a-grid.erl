-module(solution).
-export([minimumOperations/1]).

is_y_cell(R, C, N) ->
    Mid = N div 2,
    (R < Mid and (R == C or R + C == N - 1)) or (R >= Mid and C == Mid).

minimumOperations(Grid) ->
    N = length(Grid),

    InitialCounts = {0, 0, 0, 0, 0, 0},

    {_FinalR, {Y0, Y1, Y2, NonY0, NonY1, NonY2}} =
        lists:foldl(
            fun(Row, {R, AccCounts}) ->
                {_FinalC, NewAccCounts} =
                    lists:foldl(
                        fun(CellVal, {C, CurrentCounts}) ->
                            IsY = is_y_cell(R, C, N),
                            {CY0, CY1, CY2, CNy0, CNy1, CNy2} = CurrentCounts,
                            NewCounts =
                                if IsY ->
                                    case CellVal of
                                        0 -> {CY0 + 1, CY1, CY2, CNy0, CNy1, CNy2};
                                        1 -> {CY0, CY1 + 1, CY2, CNy0, CNy1, CNy2};
                                        2 -> {CY0, CY1, CY2 + 1, CNy0, CNy1, CNy2}
                                    end;
                                true ->
                                    case CellVal of
                                        0 -> {CY0, CY1, CY2, CNy0 + 1, CNy1, CNy2};
                                        1 -> {CY0, CY1, CY2, CNy0, CNy1 + 1, CNy2};
                                        2 -> {CY0, CY1, CY2, CNy0, CNy1, CNy2 + 1}
                                    end
                                end,
                            {C + 1, NewCounts}
                        end,
                        {0, AccCounts},
                        Row
                    ),
                {R + 1, NewAccCounts}
            end,
            {0, InitialCounts},
            Grid
        ),

    TotalYCells = Y0 + Y1 + Y2,
    TotalNonYCells = NonY0 + NonY1 + NonY2,

    PossibleVals = [0, 1, 2],
    MinOps = lists:foldl(
        fun(VY, AccMinOps1) ->
            lists:foldl(
                fun(VNy, AccMinOps2) ->
                    if VY == VNy -> AccMinOps2;
                       true ->
                            OpsY =
                                case VY of
                                    0 -> TotalYCells - Y0;
                                    1 -> TotalYCells - Y1;
                                    2 -> TotalYCells - Y2
                                end,
                            OpsNonY =
                                case VNy of
                                    0 -> TotalNonYCells - NonY0;
                                    1 -> TotalNonYCells - NonY1;
                                    2 -> TotalNonYCells - NonY2
                                end,
                            Ops = OpsY + OpsNonY,
                            min(AccMinOps2, Ops)
                    end
                end,
                AccMinOps1,
                PossibleVals
            )
        end,
        N * N,
        PossibleVals
    ),
    MinOps.
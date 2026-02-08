-module(solution).
-export([unique_paths_ii/1]).

unique_paths_ii(ObstacleGrid) ->
    M = length(ObstacleGrid),
    N = length(hd(ObstacleGrid)),

    case lists:nth(1, lists:nth(1, ObstacleGrid)) of
        1 -> 0;
        _ ->
            FirstDPRow = calculate_first_dp_row(N, lists:nth(1, ObstacleGrid)),
            DP_Table_Acc = build_dp_table(1, M, N, ObstacleGrid, [FirstDPRow]),
            lists:nth(N, lists:nth(M, lists:reverse(DP_Table_Acc)))
    end.

calculate_first_dp_row(N, ObstacleRow0) ->
    calculate_first_dp_row_rec(1, N, 1, ObstacleRow0, [1]).

calculate_first_dp_row_rec(ColIdx, N, PrevDPVal, ObstacleRow0, Acc) when ColIdx < N ->
    CurrentObstacle = lists:nth(ColIdx + 1, ObstacleRow0),
    NewDPVal = case CurrentObstacle of
                   1 -> 0;
                   _ -> PrevDPVal
               end,
    calculate_first_dp_row_rec(ColIdx + 1, N, NewDPVal, ObstacleRow0, [NewDPVal | Acc]);
calculate_first_dp_row_rec(N, N, _, _, Acc) ->
    lists:reverse(Acc).

build_dp_table(RowIdx, M, N, ObstacleGrid, DP_Table_Acc) when RowIdx < M ->
    PrevDPRow = hd(DP_Table_Acc),
    CurrentObstacleRow = lists:nth(RowIdx + 1, ObstacleGrid),

    CurrentDPRow = calculate_current_dp_row(N, PrevDPRow, CurrentObstacleRow),

    build_dp_table(RowIdx + 1, M, N, ObstacleGrid, [CurrentDPRow | DP_Table_Acc]);
build_dp_table(M, M, _, _, DP_Table_Acc) ->
    DP_Table_Acc.

calculate_current_dp_row(N, PrevDPRow, CurrentObstacleRow) ->
    FirstColObstacle = lists:nth(1, CurrentObstacleRow),
    FirstColDPVal = case FirstColObstacle of
                        1 -> 0;
                        _ -> lists:nth(1, PrevDPRow)
                    end,

    calculate_current_dp_row_rec(1, N, PrevDPRow, CurrentObstacleRow, [FirstColDPVal]).

calculate_current_dp_row_rec(ColIdx, N, PrevDPRow, CurrentObstacleRow, Acc) when ColIdx < N ->
    CurrentObstacle = lists:nth(ColIdx + 1, CurrentObstacleRow),
    NewDPVal = case CurrentObstacle of
                   1 -> 0;
                   _ ->
                       ValFromAbove = lists:nth(ColIdx + 1, PrevDPRow),
                       ValFromLeft = hd(Acc),
                       ValFromAbove + ValFromLeft
               end,
    calculate_current_dp_row_rec(ColIdx + 1, N, PrevDPRow, CurrentObstacleRow, [NewDPVal | Acc]);
calculate_current_dp_row_rec(N, N, _, _, Acc) ->
    lists:reverse(Acc).
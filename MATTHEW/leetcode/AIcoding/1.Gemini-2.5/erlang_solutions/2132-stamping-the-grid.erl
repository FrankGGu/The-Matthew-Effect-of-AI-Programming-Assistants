-module(solution).
-export([solve/3]).

solve(Grid, StampHeight, StampWidth) ->
    M = length(Grid),
    N = length(hd(Grid)),

    TotalZeros = count_zeros(Grid, M, N),
    if TotalZeros == 0 ->
        true;
    true ->
        if StampHeight > M or StampWidth > N ->
            false;
        true ->
            ObstacleSum = build_obstacle_sum(Grid, M, N),
            CanPlaceStamp = build_can_place_stamp(M, N, StampHeight, StampWidth, ObstacleSum),
            StampCountPrefix = build_stamp_count_prefix(CanPlaceStamp, M, N),
            check_all_zeros_covered(Grid, M, N, StampHeight, StampWidth, StampCountPrefix)
        end
    end.

count_zeros(Grid, M, N) ->
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(Cell, Acc2) ->
            if Cell == 0 -> Acc2 + 1;
            true -> Acc2
            end
        end, Acc, Row)
    end, 0, Grid).

get_val(Matrix, R_0idx, C_0idx) ->
    lists:nth(C_0idx + 1, lists:nth(R_0idx + 1, Matrix)).

get_rectangle_sum(Matrix, R1_0idx, C1_0idx, R2_0idx, C2_0idx) ->
    ValR2C2 = get_val(Matrix, R2_0idx + 1, C2_0idx + 1),
    ValR1C2 = get_val(Matrix, R1_0idx, C2_0idx + 1),
    ValR2C1 = get_val(Matrix, R2_0idx + 1, C1_0idx),
    ValR1C1 = get_val(Matrix, R1_0idx, C1_0idx),
    ValR2C2 - ValR1C2 - ValR2C1 + ValR1C1.

build_obstacle_sum(Grid, M, N) ->
    ZeroRow = lists:duplicate(N + 1, 0),
    build_obstacle_sum_rows(Grid, M, N, 1, [ZeroRow]).

build_obstacle_sum_rows(_Grid, _M, _N, R_1idx, AccMatrix) when R_1idx > _M ->
    lists:reverse(AccMatrix);
build_obstacle_sum_rows(Grid, M, N, R_1idx, AccMatrix) ->
    PrevRow_1idx = hd(AccMatrix),
    CurrentGridRow_0idx = lists:nth(R_1idx, Grid),

    CurrentObstacleSumRow_1idx = build_obstacle_sum_cols(CurrentGridRow_0idx, PrevRow_1idx, N, 1, [0]).

    build_obstacle_sum_rows(Grid, M, N, R_1idx + 1, [CurrentObstacleSumRow_1idx | AccMatrix]).

build_obstacle_sum_cols(_CurrentGridRow_0idx, _PrevRow_1idx, _N, C_1idx, AccRow) when C_1idx > _N ->
    lists:reverse(AccRow);
build_obstacle_sum_cols(CurrentGridRow_0idx, PrevRow_1idx, N, C_1idx, AccRow) ->
    GridVal = lists:nth(C_1idx, CurrentGridRow_0idx),
    ObstacleVal = if GridVal == 1 -> 1; true -> 0 end,

    PrevRowVal = lists:nth(C_1idx, PrevRow_1idx),
    PrevColVal = hd(AccRow),
    PrevDiagVal = lists:nth(C_1idx - 1, PrevRow_1idx),

    NewVal = ObstacleVal + PrevRowVal + PrevColVal - PrevDiagVal,

    build_obstacle_sum_cols(CurrentGridRow_0idx, PrevRow_1idx, N, C_1idx + 1, [NewVal | AccRow]).

build_can_place_stamp(M, N, StampHeight, StampWidth, ObstacleSum) ->
    [ [ (if R_0idx + StampHeight <= M and C_0idx + StampWidth <= N andalso
             get_rectangle_sum(ObstacleSum, R_0idx, C_0idx, R_0idx + StampHeight - 1, C_0idx + StampWidth - 1) == 0 -> 1;
           true -> 0
        end)
      || C_0idx <- lists:seq(0, N - 1) ]
    || R_0idx <- lists:seq(0, M - 1) ].

build_stamp_count_prefix(CanPlaceStamp, M, N) ->
    ZeroRow = lists:duplicate(N + 1, 0),
    build_stamp_count_prefix_rows(CanPlaceStamp, M, N, 1, [ZeroRow]).

build_stamp_count_prefix_rows(_CanPlaceStamp, _M, _N, R_1idx, AccMatrix) when R_1idx > _M ->
    lists:reverse(AccMatrix);
build_stamp_count_prefix_rows(CanPlaceStamp, M, N, R_1idx, AccMatrix) ->
    PrevRow_1idx = hd(AccMatrix),
    CurrentCanPlaceStampRow_0idx = lists:nth(R_1idx, CanPlaceStamp),

    CurrentStampCountPrefixRow_1idx = build_stamp_count_prefix_cols(CurrentCanPlaceStampRow_0idx, PrevRow_1idx, N, 1, [0]).

    build_stamp_count_prefix_rows(CanPlaceStamp, M, N, R_1idx + 1, [CurrentStampCountPrefixRow_1idx | AccMatrix]).

build_stamp_count_prefix_cols(_CurrentCanPlaceStampRow_0idx, _PrevRow_1idx, _N, C_1idx, AccRow) when C_1idx > _N ->
    lists:reverse(AccRow);
build_stamp_count_prefix_cols(CurrentCanPlaceStampRow_0idx, PrevRow_1idx, N, C_1idx, AccRow) ->
    CanPlaceStampVal = lists:nth(C_1idx, CurrentCanPlaceStampRow_0idx),

    PrevRowVal = lists:nth(C_1idx, PrevRow_1idx),
    PrevColVal = hd(AccRow),
    PrevDiagVal = lists:nth(C_1idx - 1, PrevRow_1idx),

    NewVal = CanPlaceStampVal + PrevRowVal + PrevColVal - PrevDiagVal,

    build_stamp_count_prefix_cols(CurrentCanPlaceStampRow_0idx, PrevRow_1idx, N, C_1idx + 1, [NewVal | AccRow]).

check_all_zeros_covered(Grid, M, N, StampHeight, StampWidth, StampCountPrefix) ->
    check_all_zeros_covered_rows(Grid, M, N, StampHeight, StampWidth, StampCountPrefix, 0).

check_all_zeros_covered_rows(_Grid, _M, _N, _SH, _SW, _SCP, R_0idx) when R_0idx == _M ->
    true;
check_all_zeros_covered_rows(Grid, M, N, SH, SW, SCP, R_0idx) ->
    case check_all_zeros_covered_cols(Grid, M, N, SH, SW, SCP, R_0idx, 0) of
        true ->
            check_all_zeros_covered_rows(Grid, M, N, SH, SW, SCP, R_0idx + 1);
        false ->
            false
    end.

check_all_zeros_covered_cols(_Grid, _M, _N, _SH, _SW, _SCP, _R_0idx, C_0idx) when C_0idx == _N ->
    true;
check_all_zeros_covered_cols(Grid, M, N, SH, SW, SCP, R_0idx, C_0idx) ->
    GridVal = get_val(Grid, R_0idx, C_0idx),
    if GridVal == 0 ->
        SR_min = erlang:max(0, R_0idx - SH + 1),
        SC_min = erlang:max(0, C_0idx - SW + 1),
        SR_max = R_0idx,
        SC_max = C_0idx,

        NumCoveringStamps = get_rectangle_sum(SCP, SR_min, SC_min, SR_max, SC_max),

        if NumCoveringStamps == 0 ->
            false;
        true ->
            check_all_zeros_covered_cols(Grid, M, N, SH, SW, SCP, R_0idx, C_0idx + 1)
        end;
    true ->
        check_all_zeros_covered_cols(Grid, M, N, SH, SW, SCP, R_0idx, C_0idx + 1)
    end.
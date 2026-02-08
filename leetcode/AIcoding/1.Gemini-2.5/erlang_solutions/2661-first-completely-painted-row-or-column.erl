-module(solution).
-export([first_completely_painted_row_or_column/2]).

first_completely_painted_row_or_column(Arr, Mat) ->
    M = length(Mat),
    N = length(hd(Mat)),

    NumToCoords = build_num_to_coords(Mat),

    RowCounts = array:new(M, {default, 0}),
    ColCounts = array:new(N, {default, 0}),

    iterate_arr(Arr, 0, NumToCoords, RowCounts, ColCounts, M, N).

build_num_to_coords(Mat) ->
    build_num_to_coords(Mat, 0, #{}).

build_num_to_coords([], _RowIdx, Acc) -> Acc;
build_num_to_coords([Row | Rest], RowIdx, Acc) ->
    NewAcc = build_row_coords(Row, RowIdx, 0, Acc),
    build_num_to_coords(Rest, RowIdx + 1, NewAcc).

build_row_coords([], _RowIdx, _ColIdx, Acc) -> Acc;
build_row_coords([Num | Rest], RowIdx, ColIdx, Acc) ->
    NewAcc = maps:put(Num, {RowIdx, ColIdx}, Acc),
    build_row_coords(Rest, RowIdx, ColIdx + 1, NewAcc).

iterate_arr([Num | Rest], K, NumToCoords, RowCounts, ColCounts, M, N) ->
    {R, C} = maps:get(Num, NumToCoords),

    CurrentRowCount = array:get(R, RowCounts),
    NewRowCounts = array:set(R, CurrentRowCount + 1, RowCounts),

    CurrentColCount = array:get(C, ColCounts),
    NewColCounts = array:set(C, CurrentColCount + 1, ColCounts),

    if
        CurrentRowCount + 1 == N; CurrentColCount + 1 == M ->
            K;
        true ->
            iterate_arr(Rest, K + 1, NumToCoords, NewRowCounts, NewColCounts, M, N)
    end.
-module(solution).
-export([reconstruct_matrix/3]).

reconstruct_matrix(Rows, Cols, MaxOnes) ->
    TotalOnes = MaxOnes * 2,
    if TotalOnes > Rows * Cols orelse TotalOnes < 0 ->
        [];
    true ->
        OnesInFirstRow = min(MaxOnes, Cols),
        OnesInSecondRow = MaxOnes - OnesInFirstRow,
        if OnesInSecondRow < 0 orelse OnesInSecondRow > Cols ->
            [];
        true ->
            FirstRow = lists:duplicate(OnesInFirstRow, 1) ++ lists:duplicate(Cols - OnesInFirstRow, 0),
            SecondRow = lists:duplicate(OnesInSecondRow, 1) ++ lists:duplicate(Cols - OnesInSecondRow, 0),
            [FirstRow, SecondRow]
        end
    end.
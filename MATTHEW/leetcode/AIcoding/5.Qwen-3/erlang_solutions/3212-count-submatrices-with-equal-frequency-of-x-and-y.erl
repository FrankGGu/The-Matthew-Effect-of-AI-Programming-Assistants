-module(solution).
-export([num_submatrices/1]).

num_submatrices(Mat) ->
    Rows = length(Mat),
    Cols = length(hd(Mat)),
    Count = 0,
    Count = count_submatrices(Mat, Rows, Cols, 0, 0, 0, 0),
    Count.

count_submatrices(_, _, _, R, C, _, _) when R >= 0, C >= 0, R >= length(Mat), C >= length(hd(Mat)) -> 0;
count_submatrices(Mat, Rows, Cols, R, C, X, Y) ->
    case lists:nth(R+1, Mat) of
        Row ->
            Val = lists:nth(C+1, Row),
            NewX = if Val == $X -> X + 1; true -> X end,
            NewY = if Val == $Y -> Y + 1; true -> Y end,
            if NewX == NewY -> 1 + count_submatrices(Mat, Rows, Cols, R, C+1, NewX, NewY);
               true -> count_submatrices(Mat, Rows, Cols, R, C+1, NewX, NewY)
            end
    end.
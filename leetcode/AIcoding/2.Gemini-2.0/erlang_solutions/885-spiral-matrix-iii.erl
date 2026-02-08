-module(spiral_matrix_iii).
-export([spiral_matrix_iii/3]).

spiral_matrix_iii(Rows, Cols, rStart, cStart) ->
    spiral_matrix_iii(Rows, Cols, rStart, cStart, 1, 0, 1, 0, [], Rows * Cols).

spiral_matrix_iii(_, _, _, _, _, _, _, _, Acc, 0) ->
    lists:reverse(Acc);
spiral_matrix_iii(Rows, Cols, R, C, Dx, Dy, Step, StepCount, Acc, Count) ->
    case R >= 0 and R < Rows and C >= 0 and C < Cols of
        true ->
            spiral_matrix_iii(Rows, Cols, R + Dx, C + Dy, Dx, Dy, Step, StepCount + 1, [{R, C} | Acc], Count - 1);
        false ->
            spiral_matrix_iii(Rows, Cols, R + Dx, C + Dy, Dx, Dy, Step, StepCount + 1, Acc, Count)
    end.
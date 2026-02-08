-module(solution).
-export([areMatricesEqualAfterRotation/2]).

areMatricesEqualAfterRotation(Mat, Target) ->
    check_rotations(Mat, Target, 0).

check_rotations(CurrentMat, Target, 4) ->
    false;
check_rotations(CurrentMat, Target, Count) ->
    if
        CurrentMat == Target ->
            true;
        true ->
            RotatedMat = rotate_90(CurrentMat),
            check_rotations(RotatedMat, Target, Count + 1)
    end.

rotate_90(Matrix) ->
    N = length(Matrix),
    [ lists:reverse([ lists:nth(C + 1, Row) || Row <- Matrix ]) || C <- lists:seq(0, N - 1) ].
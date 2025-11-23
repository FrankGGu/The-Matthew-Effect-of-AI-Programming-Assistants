-module(minimum_operations_to_write_letter_y).
-export([min_operations/1]).

min_operations(Grid) ->
    N = length(Grid),
    YArea = getYArea(N),
    OtherArea = N * N - length(YArea),
    {OnesInY, ZerosInY} = countValuesInArea(Grid, YArea, 1, 0),
    {OnesInOther, ZerosInOther} = countValuesInArea(Grid, complement(YArea, N), 1, 0),
    min(ZerosInY + OnesInOther, OnesInY + ZerosInOther).

getYArea(N) ->
    Middle = N div 2,
    YArea1 = [ {Middle, I} || I <- lists:seq(0, Middle) ],
    YArea2 = [ {I, I} || I <- lists:seq(Middle + 1, N - 1) ],
    YArea3 = [ {N - 1 - I, I} || I <- lists:seq(Middle + 1, N - 1) ],
    lists:usort(YArea1 ++ YArea2 ++ YArea3).

complement(YArea, N) ->
    AllCoordinates = [{X, Y} || X <- lists:seq(0, N - 1), Y <- lists:seq(0, N - 1)],
    AllCoordinates -- YArea.

countValuesInArea(Grid, Area, Ones, Zeros) ->
    countValuesInAreaHelper(Grid, Area, Ones, Zeros, 0, 0).

countValuesInAreaHelper(_Grid, [], Ones, Zeros, OnesAcc, ZerosAcc) ->
    {OnesAcc, ZerosAcc};
countValuesInAreaHelper(Grid, [{X, Y} | Rest], Ones, Zeros, OnesAcc, ZerosAcc) ->
    Value = lists:nth(Y + 1, lists:nth(X + 1, Grid)),
    case Value of
        1 ->
            countValuesInAreaHelper(Grid, Rest, Ones, Zeros, OnesAcc + 1, ZerosAcc);
        0 ->
            countValuesInAreaHelper(Grid, Rest, Ones, Zeros, OnesAcc, ZerosAcc + 1)
    end.
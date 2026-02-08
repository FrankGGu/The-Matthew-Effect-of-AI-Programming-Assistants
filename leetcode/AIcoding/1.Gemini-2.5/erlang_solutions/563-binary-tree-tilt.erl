-module(solution).
-export([find_tilt/1]).

-record(treenode, {val, left, right}).

find_tilt(Root) ->
    {_Sum, Tilt} = calc_tilt_and_sum(Root),
    Tilt.

calc_tilt_and_sum(nil) ->
    {0, 0};
calc_tilt_and_sum(#treenode{val = Val, left = Left, right = Right}) ->
    {LeftSum, LeftTilt} = calc_tilt_and_sum(Left),
    {RightSum, RightTilt} = calc_tilt_and_sum(Right),

    CurrentNodeTilt = abs(LeftSum - RightSum),

    TotalSubtreeSum = Val + LeftSum + RightSum,
    TotalTreeTilt = CurrentNodeTilt + LeftTilt + RightTilt,

    {TotalSubtreeSum, TotalTreeTilt}.
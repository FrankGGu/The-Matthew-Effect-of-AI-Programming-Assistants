-module(solution).
-export([find_tilt/1]).

-record(node, {val, left=nil, right=nil}).

find_tilt(Root) ->
    {_, Tilt} = calc_tilt(Root),
    Tilt.

calc_tilt(nil) ->
    {0, 0};
calc_tilt(#node{val=Val, left=Left, right=Right}) ->
    {LeftSum, LeftTilt} = calc_tilt(Left),
    {RightSum, RightTilt} = calc_tilt(Right),
    Tilt = LeftTilt + RightTilt + abs(LeftSum - RightSum),
    {Val + LeftSum + RightSum, Tilt}.
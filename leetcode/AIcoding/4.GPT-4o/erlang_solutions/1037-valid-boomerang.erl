-module(solution).
-export([isBoomerang/1]).

isBoomerang(PointList) ->
    {X1, Y1} = lists:nth(1, PointList),
    {X2, Y2} = lists:nth(2, PointList),
    {X3, Y3} = lists:nth(3, PointList),
    (X1 =:= X2 andalso Y1 =:= Y2) orelse 
    (X1 =:= X3 andalso Y1 =:= Y3) orelse 
    (X2 =:= X3 andalso Y2 =:= Y3) orelse 
    (X1 * (Y2 - Y3) + X2 * (Y3 - Y1) + X3 * (Y1 - Y2) =:= 0) =:= false.
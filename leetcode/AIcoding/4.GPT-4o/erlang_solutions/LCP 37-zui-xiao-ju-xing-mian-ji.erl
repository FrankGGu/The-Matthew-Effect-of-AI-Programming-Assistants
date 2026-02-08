-module(minimum_rectangle_area).
-export([min_area/1]).

min_area(Points) ->
    MinX = lists:min(lists:map(fun({X, _}) -> X end, Points)),
    MaxX = lists:max(lists:map(fun({X, _}) -> X end, Points)),
    MinY = lists:min(lists:map(fun({_, Y}) -> Y end, Points)),
    MaxY = lists:max(lists:map(fun({_, Y}) -> Y end, Points)),
    (MaxX - MinX) * (MaxY - MinY).
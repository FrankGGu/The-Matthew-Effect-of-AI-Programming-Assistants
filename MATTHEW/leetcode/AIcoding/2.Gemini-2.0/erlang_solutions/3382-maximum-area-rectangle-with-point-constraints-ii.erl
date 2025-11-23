-module(max_area_rectangle_ii).
-export([max_area_rectangle_ii/1]).

max_area_rectangle_ii(Points) ->
    max_area_rectangle_ii(Points, 0).

max_area_rectangle_ii([], MaxArea) ->
    MaxArea;
max_area_rectangle_ii([Point | Rest], MaxArea) ->
    max_area_rectangle_ii(Rest, max(MaxArea, find_max_area(Point, Points))).

find_max_area({X1, Y1}, Points) ->
    find_max_area({X1, Y1}, Points, 0).

find_max_area({X1, Y1}, [], MaxArea) ->
    MaxArea;
find_max_area({X1, Y1}, [{X2, Y2} | Rest], MaxArea) ->
    case X2 > X1 and Y2 > Y1 of
        true ->
            NewMaxArea = find_max_corner({X1, Y1, X2, Y2}, Points, 0);
            find_max_area({X1, Y1}, Rest, max(MaxArea, NewMaxArea));
        false ->
            find_max_area({X1, Y1}, Rest, MaxArea)
    end.

find_max_corner({X1, Y1, X2, Y2}, Points, MaxArea) ->
    find_max_corner({X1, Y1, X2, Y2}, Points, X2, Y2, MaxArea).

find_max_corner({X1, Y1, X2, Y2}, [], XMax, YMax, MaxArea) ->
    (XMax - X1) * (YMax - Y1);
find_max_corner({X1, Y1, X2, Y2}, [{X, Y} | Rest], XMax, YMax, MaxArea) ->
    case X > X1 and X < X2 and Y > Y1 and Y < Y2 of
        true ->
            find_max_corner({X1, Y1, X2, Y2}, Rest, XMax, YMax, MaxArea);
        false ->
           find_max_corner({X1, Y1, X2, Y2}, Rest, X2, Y2, MaxArea)
    end.
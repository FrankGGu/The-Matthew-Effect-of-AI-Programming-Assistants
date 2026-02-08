-module(max_area_rectangle).
-export([maxArea/1]).

maxArea(Points) ->
    PointsSorted = lists:sort(Points),
    MaxArea = 0,
    findMaxArea(PointsSorted, MaxArea).

findMaxArea([], MaxArea) ->
    MaxArea;
findMaxArea([P | Rest], MaxArea) ->
    findMaxArea(Rest, max(MaxArea, findArea(P, Rest))).

findArea({X1, Y1}, Points) ->
    findAreaHelper(Points, {X1, Y1}, 0).

findAreaHelper([], _P, MaxArea) ->
    MaxArea;
findAreaHelper([{X2, Y2} | Rest], {X1, Y1}, MaxArea) ->
    if
        Y2 == Y1 ->
            Area = abs(X2 - X1) * Y1,
            findAreaHelper(Rest, {X1, Y1}, max(MaxArea, Area));
        true ->
            findAreaHelper(Rest, {X1, Y1}, MaxArea)
    end.
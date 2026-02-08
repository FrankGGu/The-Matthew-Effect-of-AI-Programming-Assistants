-module(max_area_rectangle_i).
-export([solve/1]).

solve(points) ->
  solve(points, 0).

solve([], MaxArea) ->
  MaxArea;
solve([Point | Rest], MaxArea) ->
  solve(Rest, max(MaxArea, find_max_area(Point, Rest))).

find_max_area({X1, Y1}, Points) ->
  find_max_area({X1, Y1}, Points, 0).

find_max_area({X1, Y1}, [], MaxArea) ->
  MaxArea;
find_max_area({X1, Y1}, [{X2, Y2} | Rest], MaxArea) ->
  if
    X2 > X1 andalso Y2 > Y1 ->
      Area = (X2 - X1) * (Y2 - Y1),
      find_max_area({X1, Y1}, Rest, max(MaxArea, Area));
    true ->
      find_max_area({X1, Y1}, Rest, MaxArea)
  end.
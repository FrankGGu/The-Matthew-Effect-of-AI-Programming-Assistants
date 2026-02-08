-module(minimum_area_rectangle).
-export([minAreaRect/1]).

minAreaRect(Points) ->
  PointsSet = sets:from_list(Points),
  min_area_rect(Points, PointsSet, infinity).

min_area_rect([], _, Area) ->
  if Area == infinity ->
    0
  else
    Area
  end;
min_area_rect([Point | Rest], PointsSet, Area) ->
  min_area_rect_helper(Point, Rest, PointsSet, Area);
min_area_rect_helper(_, [], _, Area) ->
  min_area_rect(Rest, _, Area);
min_area_rect_helper({X1, Y1}, [{X2, Y2} | Rest], PointsSet, Area) ->
  if X1 == X2 or Y1 == Y2 ->
    min_area_rect_helper({X1, Y1}, Rest, PointsSet, Area)
  else
    if sets:is_element({X1, Y2}, PointsSet) and sets:is_element({X2, Y1}, PointsSet) ->
      NewArea = abs(X1 - X2) * abs(Y1 - Y2),
      NewArea2 = min(Area, NewArea),
      min_area_rect_helper({X1, Y1}, Rest, PointsSet, NewArea2)
    else
      min_area_rect_helper({X1, Y1}, Rest, PointsSet, Area)
    end.

infinity() -> 16777216.
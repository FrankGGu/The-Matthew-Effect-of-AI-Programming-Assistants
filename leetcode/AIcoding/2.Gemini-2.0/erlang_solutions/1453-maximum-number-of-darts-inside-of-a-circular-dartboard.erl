-module(darts).
-export([max_points_inside_circle/1]).

max_points_inside_circle(Points) ->
  max_points_inside_circle(Points, 0).

max_points_inside_circle([], Max) ->
  Max;
max_points_inside_circle([Point | Rest], Max) ->
  NewMax = max_points_inside_circle(Rest, max(Max, max_points_from_point(Point, Points))),
  max_points_inside_circle(Rest, NewMax).

max_points_from_point({X1, Y1}, Points) ->
  max_points_from_point({X1, Y1}, Points, 0).

max_points_from_point({X1, Y1}, [], Max) ->
  Max;
max_points_from_point({X1, Y1}, [Point | Rest], Max) ->
  NewMax = max(Max, max_points_from_two_points({X1, Y1}, Point, Points)),
  max_points_from_point({X1, Y1}, Rest, NewMax).

max_points_from_two_points({X1, Y1}, {X2, Y2}, Points) ->
  Dist = math:sqrt((X2 - X1) * (X2 - X1) + (Y2 - Y1) * (Y2 - Y1)),
  if Dist > 2.0 ->
    0
  else
    Dx = X2 - X1,
    Dy = Y2 - Y1,
    MidX = (X1 + X2) / 2.0,
    MidY = (Y1 + Y2) / 2.0,
    HalfDist = Dist / 2.0,
    H = math:sqrt(1.0 - HalfDist * HalfDist),
    XOffset = -Dy * H / HalfDist,
    YOffset = Dx * H / HalfDist,
    CenterX1 = MidX + XOffset,
    CenterY1 = MidY + YOffset,
    CenterX2 = MidX - XOffset,
    CenterY2 = MidY - YOffset,
    max(count_points_in_circle(CenterX1, CenterY1, Points), count_points_in_circle(CenterX2, CenterY2, Points))
  end.

count_points_in_circle(CenterX, CenterY, Points) ->
  count_points_in_circle(CenterX, CenterY, Points, 0).

count_points_in_circle(CenterX, CenterY, [], Count) ->
  Count;
count_points_in_circle(CenterX, CenterY, [{X, Y} | Rest], Count) ->
  Dist = math:sqrt((X - CenterX) * (X - CenterX) + (Y - CenterY) * (Y - CenterY)),
  if Dist =< 1.0 ->
    count_points_in_circle(CenterX, CenterY, Rest, Count + 1)
  else
    count_points_in_circle(CenterX, CenterY, Rest, Count)
  end.
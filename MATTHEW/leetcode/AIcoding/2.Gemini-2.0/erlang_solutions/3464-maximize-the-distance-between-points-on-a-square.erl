-module(maximize_distance_square).
-export([max_distance/1]).

max_distance(Points) ->
  max_distance_helper(Points, 0).

max_distance_helper([], Max) ->
  Max;
max_distance_helper([Point | Rest], Max) ->
  NewMax = max_distance_from(Point, Rest, Max),
  max_distance_helper(Rest, NewMax).

max_distance_from(_Point, [], Max) ->
  Max;
max_distance_from(Point1, [Point2 | Rest], Max) ->
  Distance = distance(Point1, Point2),
  NewMax = max(Max, Distance),
  max_distance_from(Point1, Rest, NewMax).

distance({X1, Y1}, {X2, Y2}) ->
  math:sqrt(math:pow(X2 - X1, 2) + math:pow(Y2 - Y1, 2)).
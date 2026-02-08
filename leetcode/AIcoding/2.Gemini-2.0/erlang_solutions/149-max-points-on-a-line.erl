-module(max_points_on_a_line).
-export([max_points/1]).

max_points(Points) ->
    max_points_helper(Points, 0).

max_points_helper([], Max) ->
    Max;
max_points_helper([Point | Rest], Max) ->
    MaxPoints = max_points_from_point(Point, Rest),
    max_points_helper(Rest, max(Max, MaxPoints)).

max_points_from_point(Point, Rest) ->
    max_points_from_point_helper(Point, Rest, 0, #{}, 0).

max_points_from_point_helper(_, [], Max, _, Same) ->
    max(Max, Same + 1);
max_points_from_point_helper(Point, [Other | Others], Max, Slopes, Same) ->
    {X1, Y1} = Point,
    {X2, Y2} = Other,
    if X1 == X2 andalso Y1 == Y2 ->
        max_points_from_point_helper(Point, Others, Max, Slopes, Same + 1);
    else
        Slope = calculate_slope(X1, Y1, X2, Y2),
        NewCount = maps:get(Slope, Slopes, 0) + 1,
        NewSlopes = Slopes#{Slope => NewCount},
        max_points_from_point_helper(Point, Others, max(Max, NewCount), NewSlopes, Same)
    end.

calculate_slope(X1, Y1, X2, Y2) ->
    if X1 == X2 ->
        infinity;
    else
        Gcd = gcd(Y2 - Y1, X2 - X1),
        {(Y2 - Y1) div Gcd, (X2 - X1) div Gcd}
    end.

gcd(0, B) -> abs(B);
gcd(A, 0) -> abs(A);
gcd(A, B) -> gcd(B, A rem B).
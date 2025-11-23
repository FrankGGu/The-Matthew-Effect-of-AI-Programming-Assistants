-module(max_visible_points).
-export([visible_points/3]).

visible_points(Points, Angle, Location) ->
    Angles = [angle(Point, Location) || Point <- Points],
    SortedAngles = lists:sort(Angles),
    ExtendedAngles = SortedAngles ++ [X + 360 || X <- SortedAngles],
    MaxVisible = max_visible_points(ExtendedAngles, Angle),
    MaxVisible.

angle({X1, Y1}, {X2, Y2}) ->
    math:atan2(Y1 - Y2, X1 - X2) * 180 / math:pi().

max_visible_points(Angles, Angle) ->
    N = length(Angles),
    MaxCount = max_visible_points_helper(Angles, N, Angle, 0, 0, 0),
    MaxCount.

max_visible_points_helper(Angles, N, Angle, L, R, MaxCount) when R < N ->
    if
        Angles(R) - Angles(L) <= Angle ->
            max_visible_points_helper(Angles, N, Angle, L, R + 1, max(MaxCount, R - L + 1));
        true ->
            max_visible_points_helper(Angles, N, Angle, L + 1, R, MaxCount)
    end;
max_visible_points_helper(_, _, _, _, _, MaxCount) ->
    MaxCount.
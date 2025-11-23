-module(solution).
-export([visible_points/1]).

visible_points(Points) ->
    visible_points(Points, 0, 0, 0, 0).

visible_points([], _, _, Max, _) ->
    Max;
visible_points([{X,Y}|T], Angle, Count, Max, LastAngle) ->
    % Convert point to angle
    AngleRad = math:atan2(Y, X),
    AngleDeg = AngleRad * 180 / math:pi(),
    if
        AngleDeg < 0 -> AngleDeg + 360;
        true -> AngleDeg
    end,
    NewAngle = AngleDeg,
    case abs(NewAngle - LastAngle) < 90 of
        true ->
            visible_points(T, NewAngle, Count + 1, max(Max, Count + 1), NewAngle);
        false ->
            visible_points(T, NewAngle, 1, max(Max, 1), NewAngle)
    end.
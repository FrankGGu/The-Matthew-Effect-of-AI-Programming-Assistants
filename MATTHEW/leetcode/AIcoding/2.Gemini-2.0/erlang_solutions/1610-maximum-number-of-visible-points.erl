-module(visible_points).
-export([max_visible_points/3]).

max_visible_points(points, angle, location) ->
    Xs = [X || {X, _} <- points],
    Ys = [Y || {_, Y} <- points],
    max_visible_points_helper(Xs, Ys, angle, location).

max_visible_points_helper(Xs, Ys, Angle, {X0, Y0}) ->
    Angles = [math:atan2(Y - Y0, X - X0) || {X, Y} <- lists:zip(Xs, Ys)],
    SortedAngles = lists:sort(Angles),
    N = length(Angles),
    ExtendedAngles = SortedAngles ++ [A + 2 * math:pi || A <- SortedAngles],
    RadAngle = Angle * math:pi / 180,
    max_visible_points_helper2(ExtendedAngles, RadAngle, 0, 0, N, 0).

max_visible_points_helper2(Angles, RadAngle, L, R, N, Max) ->
    case R > 2 * N - 1 of
        true ->
            Max;
        false ->
            case L > N - 1 of
                true ->
                    Max;
                false ->
                    case L >= length(Angles) - 1 of
                        true ->
                            Max;
                        false ->
                            case R >= length(Angles) of
                                true ->
                                    Max;
                                false ->
                                    if Angles[R+1] - Angles[L+1] > RadAngle ->
                                        max_visible_points_helper2(Angles, RadAngle, L + 1, R, N, Max);
                                    true ->
                                        NewMax = max(Max, R - L + 1),
                                        max_visible_points_helper2(Angles, RadAngle, L, R + 1, N, NewMax)
                            end
                    end
            end
    end.
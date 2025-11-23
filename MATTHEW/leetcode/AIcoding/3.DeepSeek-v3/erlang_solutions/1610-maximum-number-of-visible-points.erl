-module(solution).
-export([visible_points/3]).

visible_points(Points, Angle, Location) ->
    {X, Y} = Location,
    Angles = lists:foldl(fun({Px, Py}, Acc) ->
        Dx = Px - X,
        Dy = Py - Y,
        if
            Dx == 0, Dy == 0 -> Acc;
            true ->
                Theta = math:atan2(Dy, Dx) * 180 / math:pi(),
                Normalized = if Theta < 0 -> Theta + 360.0; true -> Theta end,
                [Normalized | Acc]
        end
    end, [], Points),
    Same = length(Points) - length(Angles),
    Sorted = lists:sort(Angles),
    Extended = Sorted ++ [A + 360.0 || A <- Sorted],
    Max = find_max(Extended, Angle, 0, 0, 0),
    Max + Same.

find_max([], _, _, Max, _) -> Max;
find_max([H | T], Angle, Start, Max, Index) ->
    case (H - lists:nth(Start + 1, Extended)) =< Angle of
        true ->
            NewMax = max(Max, Index - Start + 1),
            find_max(T, Angle, Start, NewMax, Index + 1);
        false ->
            find_max(T, Angle, Start + 1, Max, Index + 1)
    end.
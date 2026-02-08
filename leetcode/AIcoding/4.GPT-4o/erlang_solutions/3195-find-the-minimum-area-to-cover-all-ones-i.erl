-module(solution).
-export([minArea/2]).

minArea(Matrix, Ones) ->
    {MinX, MinY, MaxX, MaxY} = find_bounds(Matrix, Ones, {infinity, infinity, -infinity, -infinity}),
    if MinX > MaxX orelse MinY > MaxY -> 0;
    true -> (MaxX - MinX + 1) * (MaxY - MinY + 1)
    end.

find_bounds([], _, {MinX, MinY, MaxX, MaxY}) -> {MinX, MinY, MaxX, MaxY};
find_bounds([Row | Rest], Ones, {MinX, MinY, MaxX, MaxY}) ->
    find_bounds(Rest, Ones, update_bounds(Row, Ones, {MinX, MinY, MaxX, MaxY})).

update_bounds([], _, Bounds) -> Bounds;
update_bounds([H | T], Ones, {MinX, MinY, MaxX, MaxY}) ->
    case H of
        1 -> 
            NewMinX = min(MinX, 0),
            NewMaxX = max(MaxX, 0),
            NewBounds = {NewMinX, MinY, NewMaxX, MaxY},
            update_bounds(T, Ones, NewBounds);
        _ -> 
            update_bounds(T, Ones, Bounds)
    end.
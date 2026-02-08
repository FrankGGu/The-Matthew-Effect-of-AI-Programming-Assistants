-module(widest_vertical_area).
-export([max_width_between_two_points/1]).

max_width_between_two_points(Points) ->
    XCoordinates = lists:sort([X || {X, _} <- Points]),
    MaxWidth = max_width(XCoordinates, 0),
    MaxWidth.

max_width([_], Max) ->
    Max;
max_width([X1, X2 | Rest], Max) ->
    NewMax = max(Max, X2 - X1),
    max_width([X2 | Rest], NewMax).

max(A, B) ->
    if A > B -> A;
    true -> B
    end.
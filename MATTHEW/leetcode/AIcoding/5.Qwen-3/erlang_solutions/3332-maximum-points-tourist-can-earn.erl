-module(max_points_tourist_can_earn).
-export([max_points/1]).

max_points(Points) ->
    max_points(Points, 0, 0, 0).

max_points([], Prev, Current, Next) ->
    max(Prev, Current, Next);
max_points([H | T], Prev, Current, Next) ->
    NewNext = Current + H,
    NewCurrent = max(Prev, Current) + H,
    max_points(T, Current, NewNext, NewCurrent).

max(A, B, C) ->
    max(max(A, B), C).

max(A, B) ->
    if A > B -> A; true -> B end.
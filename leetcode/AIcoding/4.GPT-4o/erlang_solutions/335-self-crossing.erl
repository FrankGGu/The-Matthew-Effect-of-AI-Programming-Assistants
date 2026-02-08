-spec is_self_crossing(Distance :: [integer()]) -> boolean().
is_self_crossing(Distance) ->
    is_self_crossing(Distance, 0, 0, 0, 0).

is_self_crossing([], _, _, _, _) -> false;
is_self_crossing([D | Rest], X, Y, Prev_X, Prev_Y) ->
    New_X = X + D,
    is_crossing(X, Y, Prev_X, Prev_Y) orelse is_self_crossing(Rest, New_X, Y, X, Y);
is_self_crossing([D | Rest], X, Y, Prev_X, Prev_Y) when Y > Prev_Y ->
    New_Y = Y - D,
    is_crossing(X, Y, Prev_X, Prev_Y) orelse is_self_crossing(Rest, X, New_Y, X, Y);
is_self_crossing([D | Rest], X, Y, Prev_X, Prev_Y) when X > Prev_X ->
    New_X = X - D,
    is_crossing(X, Y, Prev_X, Prev_Y) orelse is_self_crossing(Rest, New_X, Y, X, Y).

is_crossing(X, Y, Prev_X, Prev_Y) ->
    X =:= Prev_X andalso Y =:= Prev_Y.

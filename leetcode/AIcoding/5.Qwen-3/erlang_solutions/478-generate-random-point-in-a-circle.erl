-module(generate_random_point_in_a_circle).
-export([new/3, rand_point/1]).

new(X, Y, R) ->
    {X, Y, R}.

rand_point({X, Y, R}) ->
    Rand = fun() -> random:uniform() end,
    Angle = 2 * math:pi() * Rand(),
    Radius = math:sqrt(Rand()) * R,
    X + Radius * math:cos(Angle),
    Y + Radius * math:sin(Angle).
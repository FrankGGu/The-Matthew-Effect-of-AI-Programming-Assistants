-module(solution).
-export([countPoints/2]).

countPoints(Points, Queries) ->
    [count_points_for_query(Points, Query) || Query <- Queries].

count_points_for_query(Points, [Cx, Cy, R]) ->
    RadiusSq = R * R,
    length([1 || [Px, Py] <- Points, is_inside(Px, Py, Cx, Cy, RadiusSq)]).

is_inside(Px, Py, Cx, Cy, RadiusSq) ->
    Dx = Px - Cx,
    Dy = Py - Cy,
    Dx * Dx + Dy * Dy =< RadiusSq.
-module(points_in_circle).
-export([countPoints/2]).

countPoints(Points, Queries) ->
    lists:map(fun(Query) -> count_points_in_circle(Points, Query) end, Queries).

count_points_in_circle(Points, [Cx, Cy, R]) ->
    lists:foldl(fun([Px, Py], Acc) ->
                        if is_point_inside_circle(Px, Py, Cx, Cy, R) ->
                            Acc + 1;
                        true ->
                            Acc
                        end
                end, 0, Points).

is_point_inside_circle(Px, Py, Cx, Cy, R) ->
    math:pow(Px - Cx, 2) + math:pow(Py - Cy, 2) =< math:pow(R, 2).
-module(queries_on_number_of_points_inside_a_circle).
-export([count_points/2]).

count_points(Points, Queries) ->
    lists:map(fun(Q) -> count_points_in_circle(Points, Q) end, Queries).

count_points_in_circle(Points, {X, Y, R}) ->
    lists:foldl(fun({Px, Py}, Acc) ->
        if
            math:pow(Px - X, 2) + math:pow(Py - Y, 2) =< math:pow(R, 2) -> Acc + 1;
            true -> Acc
        end
    end, 0, Points).
-module(Solution).
-export([detect_squares/1]).

-record(point, {x, y}).

detect_squares(operations) ->
    Points = lists:foldl(fun({x, y}, Acc) -> [{x, y} | Acc] end, [], operations),
    lists:map(fun(point_squares(Points, {X, Y})) end, Points).

point_squares(Points, {X, Y}) ->
    lists:foldl(fun({x2, y2}, Acc) ->
        case lists:member({X + (Y - y2), Y + (X - x2)}, Points) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, Points).
-module(number_of_boomerangs).
-export([number_of_boomerangs/1]).

number_of_boomerangs(Points) ->
    lists:sum([maps:get(V, maps:new(), 0) * (maps:get(V, maps:new(), 0) - 1) || Point <- Points,
                 V <- [distance_map(Point, Other, Points) || Other <- Points, Other /= Point]]).

distance_map(Point, Other, Points) ->
    Distances = [distance(Point, P) || P <- Points, P /= Point],
    lists:foldl(fun(D, Acc) ->
                        maps:update_with(D, fun(V) -> V + 1 end, 1, Acc)
                end, maps:new(), Distances).

distance({X1, Y1}, {X2, Y2}) ->
    (X1 - X2) * (X1 - X2) + (Y1 - Y2) * (Y1 - Y2).
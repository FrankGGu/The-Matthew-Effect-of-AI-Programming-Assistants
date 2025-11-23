-module(points_that_intersect_with_cars).
-export([cars_to_roads/1]).

cars_to_roads(Cars) ->
    lists:usort(
        lists:foldl(fun({Start, End}, Acc) ->
                            lists:seq(Start, End) ++ Acc
                    end, [], Cars)
    ).
-module(solution).
-export([number_of_points/1]).

number_of_points(Cars) ->
    CoveredPoints = lists:foldl(
        fun([Start, End], AccSet) ->
            PointsInCar = lists:seq(Start, End),
            gb_sets:add_list(PointsInCar, AccSet)
        end,
        gb_sets:new(),
        Cars
    ),
    gb_sets:size(CoveredPoints).
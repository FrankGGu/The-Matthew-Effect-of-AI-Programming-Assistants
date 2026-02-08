-module(solution).
-export([surface_area/1]).

surface_area(Shapes) ->
    TotalSurfaceArea = lists:foldl(fun(Shape, Acc) ->
        Area = Shape * Shape * 6 - (lists:sum(lists:map(fun(X) -> X * 2 end, Shape))),
        Acc + Area
    end, 0, Shapes),
    TotalSurfaceArea.
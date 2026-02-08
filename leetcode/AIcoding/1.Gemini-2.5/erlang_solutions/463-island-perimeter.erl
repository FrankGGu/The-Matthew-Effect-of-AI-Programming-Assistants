-module(solution).
-export([island_perimeter/1]).

island_perimeter(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    IsLand = fun(R, C) ->
        if R >= 0 andalso R < Rows andalso C >= 0 andalso C < Cols ->
            lists:nth(C + 1, lists:nth(R + 1, Grid)) == 1;
           true ->
            false
        end
    end,

    lists:foldl(fun(R, AccPerimeter) ->
        lists:foldl(fun(C, CurrentRowPerimeter) ->
            if IsLand(R, C) ->
                CellPerimeter = 4,
                PerimeterAfterUp = if IsLand(R - 1, C) -> CellPerimeter - 1; true -> CellPerimeter end,
                PerimeterAfterDown = if IsLand(R + 1, C) -> PerimeterAfterUp - 1; true -> PerimeterAfterUp end,
                PerimeterAfterLeft = if IsLand(R, C - 1) -> PerimeterAfterDown - 1; true -> PerimeterAfterDown end,
                PerimeterAfterRight = if IsLand(R, C + 1) -> PerimeterAfterLeft - 1; true -> PerimeterAfterLeft end,
                CurrentRowPerimeter + PerimeterAfterRight;
               true ->
                CurrentRowPerimeter
            end
        end, AccPerimeter, lists:seq(0, Cols - 1))
    end, 0, lists:seq(0, Rows - 1)).
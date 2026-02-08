-module(solution).
-export([rectangle_area/1]).

rectangle_area(Rectangles) ->
    Rects = lists:map(fun({X1, Y1, X2, Y2}) -> {X1, Y1, X2, Y2} end, Rectangles),
    Area = lists:foldl(fun({X1, Y1, X2, Y2}, Acc) ->
        Acc + (X2 - X1) * (Y2 - Y1)
    end, 0, Rects),
    Area rem 1000000007.
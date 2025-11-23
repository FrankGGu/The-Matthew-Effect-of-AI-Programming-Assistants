-module(solution).
-export([largest_square_area/2]).

largest_square_area(Rectangles1, Rectangles2) ->
    MaxArea = 0,
    lists:foldl(fun(R1, Acc1) ->
        [X1, Y1, X2, Y2] = R1,
        lists:foldl(fun(R2, Acc2) ->
            [A1, B1, A2, B2] = R2,
            XOverlap = max(0, min(X2, A2) - max(X1, A1)),
            YOverlap = max(0, min(Y2, B2) - max(Y1, B1)),
            Side = min(XOverlap, YOverlap),
            Area = Side * Side,
            max(Acc2, Area)
        end, Acc1, Rectangles2)
    end, MaxArea, Rectangles1).
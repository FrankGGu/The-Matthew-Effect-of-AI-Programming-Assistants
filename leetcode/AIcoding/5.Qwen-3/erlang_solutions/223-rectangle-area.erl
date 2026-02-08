-module(rectangle_area).
-export([compute_area/5]).

compute_area(X1, Y1, X2, Y2, X3, Y3, X4, Y4) ->
    A = (X2 - X1) * (Y2 - Y1),
    B = (X4 - X3) * (Y4 - Y3),
    OverlapX = max(0, min(X2, X4) - max(X1, X3)),
    OverlapY = max(0, min(Y2, Y4) - max(Y1, Y3)),
    OverlapArea = OverlapX * OverlapY,
    A + B - OverlapArea.
-module(solution).
-export([largest_square/2]).

largest_square(Rect1, Rect2) ->
    X1 = hd(Rect1),
    Y1 = hd(tl(Rect1)),
    X2 = hd(tl(tl(Rect1))),
    Y2 = hd(tl(tl(tl(Rect1)))),
    X3 = hd(Rect2),
    Y3 = hd(tl(Rect2)),
    X4 = hd(tl(tl(Rect2))),
    Y4 = hd(tl(tl(tl(Rect2)))),
    X_start = max(X1, X3),
    X_end = min(X2, X4),
    Y_start = max(Y1, Y3),
    Y_end = min(Y2, Y4),
    if
        X_start < X_end andalso Y_start < Y_end ->
            Side = min(X_end - X_start, Y_end - Y_start),
            Side * Side;
        true ->
            0
    end.
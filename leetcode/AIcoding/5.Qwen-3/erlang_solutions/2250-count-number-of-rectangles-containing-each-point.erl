-module(solution).
-export([count_rectangles/2]).

count_rectangles(Rectangles, Points) ->
    SortedRectangles = lists:sort(fun(A, B) -> hd(A) < hd(B) end, Rectangles),
    Results = lists:map(fun(Point) -> count_rectangles_for_point(Point, SortedRectangles) end, Points),
    Results.

count_rectangles_for_point({X, Y}, Rectangles) ->
    count_rectangles_for_point(X, Y, Rectangles, 0).

count_rectangles_for_point(_, _, [], Count) ->
    Count;
count_rectangles_for_point(X, Y, [H | T], Count) ->
    [X1, Y1, X2, Y2] = H,
    if
        X >= X1 andalso X <= X2 andalso Y >= Y1 andalso Y <= Y2 ->
            count_rectangles_for_point(X, Y, T, Count + 1);
        true ->
            count_rectangles_for_point(X, Y, T, Count)
    end.
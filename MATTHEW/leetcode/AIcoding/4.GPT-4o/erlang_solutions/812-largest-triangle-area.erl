-module(solution).
-export([largest_triangle_area/1]).

largest_triangle_area(Points) ->
    largest_triangle_area(Points, 0).

largest_triangle_area([], Max) ->
    Max;
largest_triangle_area([H|T], Max) ->
    Max1 = lists:foldl(fun(X, Acc) ->
        Max2 = lists:foldl(fun(Y, Acc2) ->
            Area = triangle_area(H, X, Y),
            max(Area, Acc2)
        end, Acc, T),
        max(Max2, Acc)
    end, Max, T),
    largest_triangle_area(T, Max1).

triangle_area({X1, Y1}, {X2, Y2}, {X3, Y3}) ->
    abs((X1 * (Y2 - Y3) + X2 * (Y3 - Y1) + X3 * (Y1 - Y2)) / 2).
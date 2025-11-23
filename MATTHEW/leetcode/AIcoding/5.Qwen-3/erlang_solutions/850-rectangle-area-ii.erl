-module(rectangle_area_ii).
-export([compute_area/1]).

compute_area(Rects) ->
    Sorted = lists:sort(fun({X1, Y1, X2, Y3}, {X3, Y4, X5, Y5}) ->
                            if X1 < X3 -> true;
                               X1 > X3 -> false;
                               true -> Y1 < Y4
                            end
                        end, Rects),
    compute_area(Sorted, 0).

compute_area([], Area) ->
    Area;
compute_area([H | T], Area) ->
    {X1, Y1, X2, Y2} = H,
    NewArea = Area + (X2 - X1) * (Y2 - Y1),
    compute_area(T, NewArea).
-module(container_with_most_water).
-export([max_area/1]).

max_area(Height) ->
    max_area(Height, 0, length(Height) - 1, 0).

max_area(_Height, Left, Right, Max) when Left >= Right ->
    Max;
max_area(Height, Left, Right, Max) ->
    H = min(element(Left + 1, Height), element(Right + 1, Height)),
    Area = H * (Right - Left),
    NewMax = max(Max, Area),
    if
        element(Left + 1, Height) < element(Right + 1, Height) ->
            max_area(Height, Left + 1, Right, NewMax);
        true ->
            max_area(Height, Left, Right - 1, NewMax)
    end.
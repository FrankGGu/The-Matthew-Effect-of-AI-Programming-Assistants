-module(perfect_rectangle).
-export([is_perfect_rectangle/1]).

is_perfect_rectangle(Rectangles) ->
    Points = lists:foldl(fun(Rect, Acc) ->
        [ {element(1, Rect), element(2, Rect)}, {element(1, Rect), element(4, Rect)},
          {element(3, Rect), element(2, Rect)}, {element(3, Rect), element(4, Rect)} ] ++ Acc
    end, [], Rectangles),
    CountMap = maps:from_list([{P, 0} || P <- Points]),
    CountMapWithUpdates = lists:foldl(fun(P, M) ->
        maps:update_with(P, fun(V) -> V + 1 end, M)
    end, CountMap, Points),
    ValidPoints = maps:filter(fun(_, V) -> V rem 2 == 1 end, CountMapWithUpdates),
    case maps:size(ValidPoints) of
        4 ->
            Sides = maps:keys(ValidPoints),
            [MinX, MaxX] = lists:usort([X || {X, _} <- Sides]),
            [MinY, MaxY] = lists:usort([Y || {_, Y} <- Sides]),
            ExpectedArea = (MaxX - MinX) * (MaxY - MinY),
            ActualArea = lists:sum([ (X2 - X1) * (Y2 - Y1) || {X1, Y1, X2, Y2} <- Rectangles ]),
            ExpectedArea == ActualArea;
        _ ->
            false
    end.
-module(solution).
-export([interchangeableRectangles/1]).

interchangeableRectangles(Rectangles) ->
    RectanglesCount = lists:map(fun({W, H}) -> W / H end, Rectangles),
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(C) -> C + 1 end, 1, Acc) end, maps:new(), RectanglesCount),
    lists:foldl(fun({_, C}, Acc) -> Acc + (C * (C - 1)) div 2 end, 0, maps:to_list(Counts)).
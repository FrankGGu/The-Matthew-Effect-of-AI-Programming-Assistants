-module(valid_square).
-export([valid_square/4]).

valid_square(X1, Y1, X2, Y2) ->
    Distances = [distance(X1, Y1, X2, Y2), distance(X1, Y1, X1, Y2), distance(X1, Y1, X2, Y1), distance(X2, Y2, X1, Y2)],
    Counts = maps:fold(fun(X, Acc) -> maps:update_with(X, fun(C) -> C + 1 end, 1, Acc) end, #{}, Distances),
    maps:size(Counts) =:= 2 andalso maps:get(0, Counts, 0) =:= 2 andalso maps:get(1, Counts, 0) =:= 4.

distance(X1, Y1, X2, Y2) ->
    (X1 - X2) * (X1 - X2) + (Y1 - Y2) * (Y1 - Y2).
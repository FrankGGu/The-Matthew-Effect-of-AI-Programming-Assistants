-module(solution).
-export([max_square_area/1]).

max_square_area(Grid) ->
    MaxRow = length(Grid),
    MaxCol = length(hd(Grid)),
    MaxSide = lists:max(lists:map(fun(Row) -> largest_square(Row) end, Grid)),
    MaxSide * MaxSide.

largest_square(Row) ->
    lists:foldl(fun(X, Acc) -> if X =:= 1 -> Acc + 1; true -> 0 end end, 0, Row).
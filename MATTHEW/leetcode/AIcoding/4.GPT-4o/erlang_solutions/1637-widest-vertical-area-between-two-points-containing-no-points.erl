-module(solution).
-export([max_width_between_vertical_lines/1]).

max_width_between_vertical_lines/1 ->
    Points = [{{1,3}, {2,1}}, {{1,1}, {2,2}}, {{1,2}, {2,3}}],
    SortedX = lists:sort([X || {X, _Y} <- Points]),
    Widths = lists:map(fun({A, B}) -> B - A end, lists:zip(SortedX, tl(SortedX))),
    lists:max(Widths).
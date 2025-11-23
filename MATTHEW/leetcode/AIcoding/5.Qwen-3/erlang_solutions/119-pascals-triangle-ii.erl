-module(pascals_triangle_ii).
-export([get_row/1]).

get_row(0) -> [1];
get_row(N) ->
    Previous = get_row(N-1),
    [1 | [lists:nth(I, Previous) + lists:nth(I+1, Previous) || I <- lists:seq(0, length(Previous)-2)] ++ [1]].
-module(solution).
-export([get_size/1]).

get_size(DataFrame) ->
    {Rows, Cols} = lists:foldl(fun(Row, {R, C}) -> {R + 1, length(Row)} end, {0, 0}, DataFrame),
    {Rows, Cols}.
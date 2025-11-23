-module(solution).
-export([min_falling_path_sum/1]).

min_falling_path_sum(T) ->
    {Rows, Cols} = lists:foldl(fun(Row, {R, C}) -> {R + 1, length(Row)} end, {0, 0}, T),
    lists:foldr(fun(Row, Acc) -> lists:map2(fun(X, Y) -> X + Y end, Row, lists:nth(Acc, T)) end, Acc, lists:seq(1, Rows)) end, T).

min_falling_path_sum(matrix) ->
    Rows = length(matrix),
    lists:foldl(fun(Row, Acc) -> 
        lists:map(fun({X, I}) -> X + lists:min([lists:nth(I - 1, Acc), lists:nth(I, Acc), lists:nth(I + 1, Acc)]) end, lists:zip(Row, lists:seq(1, length(Row)))) 
    end, lists:last(matrix), lists:seq(1, Rows - 1)).
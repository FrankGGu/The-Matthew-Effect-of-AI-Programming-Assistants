-module(solution).
-export([min_path_sum/1]).

min_path_sum(Triangle) ->
    MinPath = lists:foldl(fun(Row, Acc) ->
        lists:zipwith(fun(X, Y) -> X + min(Y) end, Row, Acc)
    end, lists:last(Triangle), lists:reverse(Triangle)),
    min(MinPath).

min([H | T]) -> min(H, min(T)).
min(X, []) -> X;
min(X, [H | T]) -> min(min(X, H), T).
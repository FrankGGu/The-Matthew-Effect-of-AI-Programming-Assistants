-module(solution).
-export([countBalls/2]).

countBalls(Min, Max) ->
    Counts = lists:foldl(fun(N, Acc) ->
        Box = digit_sum(N),
        maps:update(Box, 1, fun(X) -> X + 1 end, Acc)
    end, maps:new(), lists:seq(Min, Max)),
    maps:fold(fun(_, V, Acc) -> max(V, Acc) end, 0, Counts).

digit_sum(N) ->
    lists:sum(digits(N)).

digits(0) -> [];
digits(N) -> digits(N div 10) ++ [N rem 10].
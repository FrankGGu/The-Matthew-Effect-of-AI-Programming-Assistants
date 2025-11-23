-module(solution).
-export([count_negatives/1]).

-spec count_negatives(Grid :: [[integer()]]) -> integer().
count_negatives(Grid) ->
    lists:foldl(fun(Row, Acc) ->
                    Acc + length(lists:dropwhile(fun(X) -> X >= 0 end, Row))
                end, 0, Grid).
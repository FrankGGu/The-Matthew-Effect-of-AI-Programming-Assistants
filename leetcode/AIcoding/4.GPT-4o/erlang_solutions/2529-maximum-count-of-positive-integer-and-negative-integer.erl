-module(solution).
-export([maximum_count/1]).

maximum_count(List) ->
    PositiveCount = lists:foldl(fun(X, Acc) -> if X > 0 -> Acc + 1; true -> Acc end end, 0, List),
    NegativeCount = lists:foldl(fun(X, Acc) -> if X < 0 -> Acc + 1; true -> Acc end end, 0, List),
    max(PositiveCount, NegativeCount).
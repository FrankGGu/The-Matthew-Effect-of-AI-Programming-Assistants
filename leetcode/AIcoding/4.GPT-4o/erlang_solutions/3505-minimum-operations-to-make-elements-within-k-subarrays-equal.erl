-module(solution).
-export([min_operations/3]).

min_operations(N, K, A) ->
    Counts = lists:map(fun(X) -> lists:foldl(fun(Y, Acc) -> Acc + (if Y == X -> 1; true -> 0 end) end, 0, A) end, lists:uniq(A),
        lists:seq(1, length(A)),
        {ok, Result} = lists:foldl(fun(X, Acc) -> Acc + (X - K) end, 0, Counts),
        lists:sum(Result).
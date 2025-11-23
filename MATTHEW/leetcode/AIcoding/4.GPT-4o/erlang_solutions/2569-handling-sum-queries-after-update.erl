-module(Solution).
-export([handle_sum_queries/3]).

handle_sum_queries(N, A, Queries) ->
    PrefixSums = lists:foldl(fun(X, Acc) -> [X + hd(Acc)] ++ Acc end, [0], A),
    handle_queries(PrefixSums, Queries).

handle_queries(PrefixSums, Queries) ->
    lists:map(fun({L, R}) ->
        PrefixSums[R + 1] - PrefixSums[L]
    end, Queries).
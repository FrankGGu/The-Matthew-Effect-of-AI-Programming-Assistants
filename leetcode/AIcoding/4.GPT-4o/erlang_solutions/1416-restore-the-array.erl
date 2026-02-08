-module(solution).
-export([number_of_arrays/2]).

number_of_arrays(N, K) ->
    M = 1000000007,
    count_arrays(N, K, M).

count_arrays(N, K, M) ->
    F = lists:duplicate(N + 1, 0),
    F[1] = 1,
    lists:foldl(fun(_, Acc) -> 
        lists:foldl(fun(X, Acc1) -> 
            Acc1 + lists:sum(lists:sublist(F, lists:max(0, X - K), K)) rem M 
        end, Acc, lists:seq(1, N)
        )
    end, 0, lists:seq(2, N)),
    lists:nth(N + 1, F) rem M.
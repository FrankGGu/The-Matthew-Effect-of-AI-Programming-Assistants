-module(solution).
-export([k_longest_subarray/2]).

k_longest_subarray(Numbers, K) ->
    N = length(Numbers),
    Sum = 0,
    lists:foldl(fun(I, Acc) ->
                        Sub = lists:sublist(Numbers, I, K),
                        X = lists:sum(Sub),
                        Acc + X
                    end, Sum, lists:seq(1, N - K + 1)).
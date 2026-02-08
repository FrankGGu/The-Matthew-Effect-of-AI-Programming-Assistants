-module(solution).
-export([find_kth_largest/3]).

find_kth_largest(Matrix, K) ->
    N = length(Matrix),
    M = length(hd(Matrix)),
    Values = [XorValue(X, Y, Matrix, N, M) || X <- lists:seq(0, N-1), Y <- lists:seq(0, M-1)],
    SortedValues = lists:sort(> , Values),
    lists:nth(K, SortedValues).

XorValue(X, Y, Matrix, N, M) ->
    lists:foldl(fun({I, Row}, Acc) ->
        Acc bor (Row band (1 bsl (X bxor Y)))
    end, 0, lists:zip(lists:seq(0, N-1), Matrix)).
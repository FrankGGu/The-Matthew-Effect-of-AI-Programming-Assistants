-module(solution).
-export([kthSmallestSum/2]).

kthSmallestSum(Matrix, K) ->
    SortedSums = lists:sort(matrix_sums(Matrix, K)),
    lists:nth(K, SortedSums).

matrix_sums([], _) -> [];
matrix_sums(Matrix, K) ->
    lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun(X, Acc1) ->
            NewSums = [X + Sum || Sum <- Acc1],
            lists:sort(NewSums) ++ Acc1
        end, [0], Row)
    end, [], Matrix).
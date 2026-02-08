-module(solution).
-export([max_min_sums/2]).

max_min_sums(List, K) ->
    MaxSum = max_k_sum(List, K),
    MinSum = min_k_sum(List, K),
    {MaxSum, MinSum}.

max_k_sum(List, K) ->
    lists:foldl(fun(X, Acc) -> 
        lists:foldl(fun(Y, Acc1) -> 
            lists:sum(lists:sublist([X | Y], K)) 
        end, Acc, lists:sublist(List, 1) ++ [X]) 
    end, 0, List).

min_k_sum(List, K) ->
    lists:foldl(fun(X, Acc) -> 
        lists:foldl(fun(Y, Acc1) -> 
            lists:sum(lists:sublist([X | Y], K)) 
        end, Acc, lists:sublist(List, 1) ++ [X]) 
    end, 0, List).
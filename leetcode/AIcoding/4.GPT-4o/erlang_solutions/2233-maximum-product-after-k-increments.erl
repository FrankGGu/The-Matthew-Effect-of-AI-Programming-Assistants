-module(solution).
-export([maximum_product_after_k_increments/2]).

maximum_product_after_k_increments(Nums, K) ->
    SortedNums = lists:sort(Nums),
    MaxNum = lists:last(SortedNums),
    NewMaxNum = MaxNum + K,
    lists:foldl(fun(X, Acc) -> Acc * X end, NewMaxNum, lists:sublist(SortedNums, 1, length(SortedNums) - 1)).
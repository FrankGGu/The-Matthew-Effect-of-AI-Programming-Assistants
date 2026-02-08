-module(minimum_sum_by_dividing_array).
-export([minimumSum:2]).

minimumSum(Nums, K) ->
    minimumSum_helper(Nums, K, 0).

minimumSum_helper([], _K, Acc) ->
    Acc;
minimumSum_helper(Nums, K, Acc) ->
    case K =:= 1 of
        true ->
            Sum = lists:sum(Nums),
            Acc + Sum;
        false ->
            N = length(Nums),
            Min = lists:min(Nums),
            Index = lists:keyfind(Min, 1, lists:zip(Nums, lists:seq(1,N))),
            {_, MinIndex} = Index,
            NewNums1 = lists:sublist(Nums, 1, MinIndex - 1),
            NewNums2 = lists:sublist(Nums, MinIndex + 1, N - MinIndex),
            minimumSum_helper(NewNums1 ++ NewNums2, K - 1, Acc + Min)
    end.
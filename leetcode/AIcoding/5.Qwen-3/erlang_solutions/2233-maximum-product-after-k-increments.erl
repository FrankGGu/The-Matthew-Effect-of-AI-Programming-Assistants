-module(max_product_after_k_increments).
-export([maximumProduct/2]).

maximumProduct(Nums, K) ->
    NumsSorted = lists:sort(Nums),
    MaxHeap = lists:reverse(NumsSorted),
    doIncrement(MaxHeap, K).

doIncrement([], _) -> 0;
doIncrement([H | T], 0) -> 
    product([H | T]);
doIncrement([H | T], K) ->
    NewH = H + 1,
    doIncrement(lists:usort([NewH | T]), K - 1).

product(List) ->
    product(List, 1).

product([], Acc) -> Acc;
product([H | T], Acc) ->
    product(T, Acc * H).
-module(solution).
-export([numSubarrayProductLessThanK/2]).

numSubarrayProductLessThanK(Array, K) ->
    numSubarrayProductLessThanK(Array, K, 1, 0, 0).

numSubarrayProductLessThanK([], _, _, Count, _) -> Count;
numSubarrayProductLessThanK([H | T], K, Product, Count, Start) ->
    NewProduct = Product * H,
    case NewProduct < K of
        true ->
            numSubarrayProductLessThanK(T, K, NewProduct, Count + Start + 1, Start + 1);
        false ->
            numSubarrayProductLessThanK(T, K, Product, Count, Start + 1)
    end.
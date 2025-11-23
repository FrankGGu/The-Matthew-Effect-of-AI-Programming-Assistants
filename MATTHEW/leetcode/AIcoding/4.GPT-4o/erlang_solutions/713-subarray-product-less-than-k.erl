-module(solution).
-export([num_subarray_product_less_than_k/2]).

num_subarray_product_less_than_k(Numbers, K) ->
    num_subarrays(Numbers, K, 1, 0, 0).

num_subarrays([], _, _, Count, _) -> 
    Count;
num_subarrays([H | T], K, Product, Count, Start) ->
    NewProduct = Product * H,
    case NewProduct >= K of
        true ->
            num_subarrays(T, K, 1, Count, Start + 1);
        false ->
            NewCount = Count + (length(T) + 1),
            num_subarrays(T, K, NewProduct, NewCount, Start)
    end.
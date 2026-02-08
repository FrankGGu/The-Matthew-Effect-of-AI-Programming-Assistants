-module(subarray_product_less_than_k).
-export([num_subarray_product_less_than_k/1]).

num_subarray_product_less_than_k(Nums) ->
    num_subarray_product_less_than_k(Nums, 1, 0, 0).

num_subarray_product_less_than_k([], _, _, Count) ->
    Count;
num_subarray_product_less_than_k([H | T], Product, Left, Count) ->
    NewProduct = Product * H,
    if
        NewProduct < K ->
            num_subarray_product_less_than_k(T, NewProduct, Left, Count + (Right - Left + 1));
        true ->
            num_subarray_product_less_than_k(T, H, Left + 1, Count)
    end.
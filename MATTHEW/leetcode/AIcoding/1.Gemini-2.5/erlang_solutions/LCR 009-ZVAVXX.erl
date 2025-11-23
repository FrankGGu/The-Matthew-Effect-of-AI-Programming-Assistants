-module(solution).
-export([subarray_product_less_than_k/2]).

subarray_product_less_than_k(Nums, K) when K =< 1 ->
    0;
subarray_product_less_than_k(Nums, K) ->
    Arr = array:from_list(Nums),
    Size = array:size(Arr),
    subarray_product_less_than_k_impl(Arr, K, Size, 0, 0, 1, 0).

subarray_product_less_than_k_impl(Arr, K, Size, Left, Right, Product, Count) when Right < Size ->
    RightNum = array:get(Right, Arr),
    NewProduct = Product * RightNum,
    {AdjustedProduct, NewLeft} = adjust_window(Arr, K, NewProduct, Left, Right),
    NewCount = Count + (Right - NewLeft + 1),
    subarray_product_less_than_k_impl(Arr, K, Size, NewLeft, Right + 1, AdjustedProduct, NewCount);
subarray_product_less_than_k_impl(_Arr, _K, _Size, _Left, _Right, _Product, Count) ->
    Count.

adjust_window(Arr, K, Product, Left, Right) when Product >= K, Left =< Right ->
    LeftNum = array:get(Left, Arr),
    adjust_window(Arr, K, Product div LeftNum, Left + 1, Right);
adjust_window(_Arr, _K, Product, Left, _Right) ->
    {Product, Left}.
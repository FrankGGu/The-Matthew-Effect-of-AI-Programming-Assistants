-module(solutions).
-export([num_subarray_product_less_than_k/1]).

num_subarray_product_less_than_k(Nums) ->
    num_subarray_product_less_than_k(Nums, 1, 0, 1, 0).

num_subarray_product_less_than_k([], _, _, _, Count) ->
    Count;
num_subarray_product_less_than_k([H | T], Left, Right, Product, Count) ->
    NewProduct = Product * H,
    if
        NewProduct < K ->
            num_subarray_product_less_than_k(T, Left, Right + 1, NewProduct, Count + Right + 1);
        true ->
            NewLeft = Left + 1,
            NewProduct2 = if
                              NewLeft > Right -> 1;
                              true -> product_from(Nums, NewLeft, Right)
                          end,
            num_subarray_product_less_than_k(T, NewLeft, Right, NewProduct2, Count)
    end.

product_from(_, _, -1) ->
    1;
product_from(Nums, Start, End) ->
    product_from(Nums, Start, End, 1).

product_from([], _, _, Acc) ->
    Acc;
product_from([H | T], Start, End, Acc) when Start == 0 andalso End == 0 ->
    H * Acc;
product_from([H | T], Start, End, Acc) ->
    product_from(T, Start - 1, End - 1, Acc * H).
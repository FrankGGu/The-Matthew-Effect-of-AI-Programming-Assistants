-module(subarray_product_less_than_k).
-export([num_subarray_product_less_than_k/2]).

num_subarray_product_less_than_k(Nums, K) ->
    num_subarray_product_less_than_k(Nums, K, 1, 0, 0).

num_subarray_product_less_than_k([], _, _, Count, _) ->
    Count;
num_subarray_product_less_than_k(_, K, _, Count, _) when K =< 1 ->
    Count;
num_subarray_product_less_than_k(Nums, K, Prod, Count, Left) ->
    num_subarray_product_less_than_k(Nums, K, Prod, Count, Left, 0).

num_subarray_product_less_than_k(Nums, K, Prod, Count, Left, Right) when Right >= length(Nums) ->
    Count;
num_subarray_product_less_than_k(Nums, K, Prod, Count, Left, Right) ->
    Num = lists:nth(Right + 1, Nums),
    NewProd = Prod * Num,
    case NewProd < K of
        true ->
            NewCount = Count + (Right - Left + 1),
            num_subarray_product_less_than_k(Nums, K, NewProd, NewCount, Left, Right + 1);
        false ->
            case Left == Right of
                true ->
                    num_subarray_product_less_than_k(Nums, K, 1, Count, Left + 1, Left + 1);
                false ->
                    num_subarray_product_less_than_k(Nums, K, Prod div lists:nth(Left + 1, Nums), Count, Left + 1, Right)
            end
    end.
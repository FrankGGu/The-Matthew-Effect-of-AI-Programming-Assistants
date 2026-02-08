-module(subarray_product_less_than_k).
-export([num_subarray_product_less_than_k/2]).

num_subarray_product_less_than_k(Nums, K) ->
  num_subarray_product_less_than_k(Nums, K, 0, 1, 0, 0).

num_subarray_product_less_than_k([], _K, _Left, _Product, Count, Right) ->
  Count;
num_subarray_product_less_than_k(Nums, K, Left, Product, Count, Right) when Right >= length(Nums) ->
  Count;
num_subarray_product_less_than_k(Nums, K, Left, Product, Count, Right) ->
  Num = lists:nth(Right + 1, Nums),
  NewProduct = Product * Num,
  case NewProduct < K of
    true ->
      NewCount = Count + (Right - Left + 1),
      num_subarray_product_less_than_k(Nums, K, Left, NewProduct, NewCount, Right + 1);
    false ->
      case Left =< Right of
        true ->
          NewLeft = adjust_left(Nums, K, Left, Right, NewProduct);
          NewNum = lists:nth(Right + 1, Nums),
          NewProduct2 = product_from(Nums, NewLeft, Right),
          num_subarray_product_less_than_k(Nums, K, NewLeft, NewProduct2, Count, Right + 1);
        false ->
          num_subarray_product_less_than_k(Nums, K, Right + 1, 1, Count, Right + 1)
      end
  end.

adjust_left(Nums, K, Left, Right, Product) ->
  case Product < K of
    true ->
      Left;
    false ->
      Num = lists:nth(Left + 1, Nums),
      case Product div Num < K of
        true ->
          Left + 1;
        false ->
          adjust_left(Nums, K, Left + 1, Right, Product div Num)
      end
  end.

product_from(Nums, Left, Right) ->
  product_from(Nums, Left, Right, 1).

product_from(Nums, Left, Right, Acc) when Left > Right ->
  Acc;
product_from(Nums, Left, Right, Acc) ->
  Num = lists:nth(Left + 1, Nums),
  product_from(Nums, Left + 1, Right, Acc * Num).
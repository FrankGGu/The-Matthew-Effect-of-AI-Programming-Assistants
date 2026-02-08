-module(maximum_product_subarray).
-export([max_product/1]).

max_product(Nums) ->
  max_product_helper(Nums, hd(Nums), hd(Nums), 1).

max_product_helper([H|T], MaxProduct, CurrentMax, CurrentMin) ->
  NewMax = max(H, max(CurrentMax * H, CurrentMin * H)),
  NewMin = min(H, min(CurrentMax * H, CurrentMin * H)),
  NewMaxProduct = max(MaxProduct, NewMax),
  case T of
    [] -> NewMaxProduct;
    _ -> max_product_helper(T, NewMaxProduct, NewMax, NewMin)
  end.

max(A, B) -> if A > B -> A; true -> B end.
min(A, B) -> if A < B -> A; true -> B end.
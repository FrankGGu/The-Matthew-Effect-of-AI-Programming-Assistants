-module(maximum_product).
-export([maximum_product/1]).

maximum_product(Nums) ->
  lists:sort(Nums, fun(A, B) -> A < B end) ->
  case length(Nums) of
    Len when Len < 3 -> 0;
    _ ->
      Len = length(Nums),
      Max1 = lists:nth(1, Nums) * lists:nth(2, Nums) * lists:nth(Len, Nums),
      Max2 = lists:nth(Len - 2, Nums) * lists:nth(Len - 1, Nums) * lists:nth(Len, Nums),
      max(Max1, Max2)
  end.

max(A, B) ->
  if
    A > B -> A;
    true -> B
  end.
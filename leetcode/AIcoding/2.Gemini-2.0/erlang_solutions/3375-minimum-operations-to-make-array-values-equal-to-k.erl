-module(minimum_operations).
-export([min_operations/2]).

min_operations(Nums, K) ->
  min_operations(Nums, K, 0).

min_operations([], _K, Count) ->
  Count;
min_operations([H|T], K, Count) ->
  if
    H < K ->
      min_operations(T, K, Count + 1);
    true ->
      min_operations(T, K, Count)
  end.
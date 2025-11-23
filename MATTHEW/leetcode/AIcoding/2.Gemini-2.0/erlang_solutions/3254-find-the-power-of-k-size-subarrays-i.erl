-module(find_power_k_size_subarrays_i).
-export([find_power/2]).

find_power(Nums, K) ->
  find_power(Nums, K, 0).

find_power([], _, Acc) ->
  Acc;
find_power(Nums, K, Acc) ->
  Len = length(Nums),
  if Len < K then
    Acc
  else
    Subarray = lists:sublist(Nums, 1, K),
    Power = lists:foldl(fun(X, Acc1) -> Acc1 + X end, 0, Subarray),
    find_power(lists:sublist(Nums, 2, Len - 1), K, Acc + Power)
  end.
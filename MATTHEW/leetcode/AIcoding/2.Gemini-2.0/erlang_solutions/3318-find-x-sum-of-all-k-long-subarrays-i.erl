-module(find_x_sum).
-export([k_sum/2]).

k_sum(Nums, K) ->
  k_sum(Nums, K, 0).

k_sum([], _, Acc) ->
  Acc;
k_sum(Nums, K, Acc) ->
  Len = length(Nums),
  if
    Len < K ->
      Acc;
    true ->
      Subarray = lists:sublist(Nums, K),
      Sum = lists:sum(Subarray),
      k_sum(tl(Nums), K, Acc + Sum)
  end.
-module(maximum_or).
-export([maximum_or/2]).

maximum_or(Nums, K) ->
  maximum_or(Nums, K, 0).

maximum_or([], _K, Acc) ->
  Acc;
maximum_or([H | T], K, Acc) ->
  NewH = H,
  NewK = K,
  maximum_or(T, NewK, max(Acc, H bor (H bsl K))).
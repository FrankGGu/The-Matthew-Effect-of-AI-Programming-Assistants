-module(solution).
-export([maxOperations/2]).

maxOperations(Nums, K) ->
  maxOperations(Nums, K, 0).

maxOperations([], _, Acc) ->
  Acc;
maxOperations([H|T], K, Acc) ->
  case H < K of
    true ->
      maxOperations(T, K - H, Acc + 1);
    false ->
      maxOperations(T, K, Acc)
  end.
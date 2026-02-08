-module(sliding_subarray_beauty).
-export([sliding_subarray_beauty/3]).

sliding_subarray_beauty(Nums, K, X) ->
  sliding_subarray_beauty(Nums, K, X, []).

sliding_subarray_beauty([], _K, _X, Acc) ->
  lists:reverse(Acc);
sliding_subarray_beauty(Nums, K, X, Acc) ->
  {Subarray, Rest} = lists:split(K, Nums),
  case length(Subarray) == K of
    true ->
      Sorted = lists:sort(Subarray),
      Val = lists:nth(X, Sorted),
      case Val < 0 of
        true ->
          sliding_subarray_beauty(Rest, K, X, [Val | Acc]);
        false ->
          sliding_subarray_beauty(Rest, K, X, [0 | Acc])
      end;
    false ->
      lists:reverse(Acc)
  end.
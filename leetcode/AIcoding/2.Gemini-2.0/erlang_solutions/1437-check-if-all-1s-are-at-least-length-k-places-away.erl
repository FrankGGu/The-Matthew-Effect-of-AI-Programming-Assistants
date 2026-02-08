-module(solution).
-export([k_length_apart/2]).

k_length_apart(Nums, K) ->
  k_length_apart(Nums, K, -100000).

k_length_apart([], _K, _Last) ->
  true;
k_length_apart([0 | Rest], K, Last) ->
  k_length_apart(Rest, K, Last);
k_length_apart([1 | Rest], K, Last) ->
  if
    Last == -100000 ->
      k_length_apart(Rest, K, 0);
    true ->
      if
        0 - Last >= K ->
          k_length_apart(Rest, K, 0);
        true ->
          false
      end
  end.
-module(k_diff_pairs).

-export([find_pairs/2]).

find_pairs(Nums, K) ->
  find_pairs_helper(lists:sort(Nums), K, sets:new()).

find_pairs_helper([], _K, Acc) ->
  sets:size(Acc);
find_pairs_helper([H|T], K, Acc) ->
  case find_pair(T, H, K) of
    true ->
      find_pairs_helper(T, K, sets:add({min(H, H+K), max(H, H+K)}, Acc));
    false ->
      find_pairs_helper(T, K, Acc)
  end.

find_pair([], _H, _K) ->
  false;
find_pair([H2|T], H, K) ->
  Diff = abs(H2 - H),
  if
    Diff == K ->
      true;
    Diff < K ->
      find_pair(T, H, K);
    true ->
      false
  end.
-module(swap_pairs).
-export([swap_pairs/1]).

swap_pairs(List) ->
  swap_pairs_helper(List, []).

swap_pairs_helper([], Acc) ->
  lists:reverse(Acc);
swap_pairs_helper([A], Acc) ->
  lists:reverse([A | Acc]);
swap_pairs_helper([A, B | Rest], Acc) ->
  swap_pairs_helper(Rest, [B, A | Acc]).
-module(increasing_triplet).
-export([increasing_triplet_subsequence/1]).

increasing_triplet_subsequence(Nums) ->
  increasing_triplet_subsequence(Nums, infinity, infinity).

increasing_triplet_subsequence([], _, _) ->
  false;
increasing_triplet_subsequence([H|T], First, Second) ->
  case true of
    H =< First ->
      increasing_triplet_subsequence(T, H, Second);
    H =< Second ->
      increasing_triplet_subsequence(T, First, H);
    true ->
      true
  end.
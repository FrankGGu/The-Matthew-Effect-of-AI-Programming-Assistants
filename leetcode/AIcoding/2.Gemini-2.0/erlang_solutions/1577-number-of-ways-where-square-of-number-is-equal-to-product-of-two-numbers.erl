-module(num_ways).
-export([num_ways/2]).

num_ways(Nums1, Nums2) ->
  num_ways(Nums1, Nums2, 0) + num_ways(Nums2, Nums1, 0).

num_ways([], _, Acc) ->
  Acc;
num_ways([H | T], Other, Acc) ->
  Square = H * H,
  Count = count_pairs(Other, Square, 0),
  num_ways(T, Other, Acc + Count).

count_pairs([], _, Acc) ->
  Acc;
count_pairs([A | Rest], Square, Acc) ->
  count_pairs(Rest, Square, Acc + count_pairs_helper(Rest, Square, A, 0)).

count_pairs_helper([], _, _, Acc) ->
  Acc;
count_pairs_helper([B | Rest], Square, A, Acc) ->
  case A * B == Square of
    true ->
      count_pairs_helper(Rest, Square, A, Acc + 1);
    false ->
      count_pairs_helper(Rest, Square, A, Acc)
  end.
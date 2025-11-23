-module(count_good_triplets).
-export([count_good_triplets/4]).

count_good_triplets(Arr, A, B, C) ->
  count_good_triplets(Arr, A, B, C, 0).

count_good_triplets([], _, _, _, Count) ->
  Count;
count_good_triplets([H | T], A, B, C, Count) ->
  count_good_triplets(H, T, A, B, C, Count, 0).

count_good_triplets(_, [], _, _, _, Count, Acc) ->
  Count + Acc;
count_good_triplets(I, [J | T], A, B, C, Count, Acc) ->
  count_good_triplets(I, J, T, A, B, C, Count, Acc, 0).

count_good_triplets(_, _, [], _, _, _, Count, Acc) ->
  Count + Acc;
count_good_triplets(I, J, [K | T], A, B, C, Count, Acc, Acc2) ->
  case check_triplet(I, J, K, A, B, C) of
    true ->
      count_good_triplets(I, J, T, A, B, C, Count, Acc, Acc2 + 1);
    false ->
      count_good_triplets(I, J, T, A, B, C, Count, Acc, Acc2)
  end.

check_triplet(I, J, K, A, B, C) ->
  abs(I - J) =< A andalso abs(J - K) =< B andalso abs(I - K) =< C.

count_good_triplets(H, T, A, B, C, Count, Acc) ->
  count_good_triplets(H, T, A, B, C, Count, Acc + count_good_triplets(H, T, A, B, C, 0, 0)).
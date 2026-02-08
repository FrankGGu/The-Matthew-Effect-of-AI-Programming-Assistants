-module(count_good_triplets).
-export([count_good_triplets/4]).

count_good_triplets(Arr, A, B, C) ->
  count_good_triplets(Arr, A, B, C, 0, 0).

count_good_triplets([], _, _, _, Count, _I) ->
  Count;
count_good_triplets([H1 | T], A, B, C, Count, I) ->
  count_good_triplets(T, A, B, C, count_good_triplets_helper(H1, T, A, B, C, Count, I + 1), I + 1).

count_good_triplets_helper(_, [], _, _, _, Count, _J) ->
  Count;
count_good_triplets_helper(H1, [H2 | T], A, B, C, Count, J) ->
  count_good_triplets_helper(H1, T, A, B, C, count_good_triplets_helper2(H1, H2, T, A, B, C, Count, J + 1), J + 1).

count_good_triplets_helper2(H1, H2, [], A, B, C, Count, _K) ->
  Count;
count_good_triplets_helper2(H1, H2, [H3 | T], A, B, C, Count, K) ->
  case is_good_triplet(H1, H2, H3, A, B, C) of
    true ->
      count_good_triplets_helper2(H1, H2, T, A, B, C, Count + 1, K + 1);
    false ->
      count_good_triplets_helper2(H1, H2, T, A, B, C, Count, K + 1)
  end.

is_good_triplet(I, J, K, A, B, C) ->
  abs(I - J) =< A andalso abs(J - K) =< B andalso abs(I - K) =< C.
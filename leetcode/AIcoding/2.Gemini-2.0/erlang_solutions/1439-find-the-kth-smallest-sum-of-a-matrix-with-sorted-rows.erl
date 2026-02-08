-module(kth_smallest_matrix_sum).
-export([kth_smallest/2]).

kth_smallest(Mat, K) ->
  kth_smallest_helper(Mat, K).

kth_smallest_helper(Mat, K) ->
  FirstRow = hd(Mat),
  RestRows = tl(Mat),
  kth_smallest_internal(FirstRow, RestRows, K).

kth_smallest_internal(Sums, [], K) ->
  lists:nth(K, lists:sort(Sums));
kth_smallest_internal(Sums, [Row|Rest], K) ->
  NewSums = merge_k_smallest(Sums, Row, K),
  kth_smallest_internal(NewSums, Rest, K).

merge_k_smallest(Sums, Row, K) ->
  lists:sublist(lists:sort([Sum + Val || Sum <- Sums, Val <- Row]), K).
-module(kth_smallest).
-export([kth_smallest/2]).

kth_smallest(Matrix, K) ->
  N = length(Matrix),
  kth_smallest_helper(Matrix, 0, element(2, lists:last(lists:flatten(Matrix))), K, N).

kth_smallest_helper(Matrix, Low, High, K, N) ->
  if Low >= High ->
    Low;
  true ->
    Mid = Low + (High - Low) div 2,
    Count = count_less_equal(Matrix, Mid, N),
    if Count < K ->
      kth_smallest_helper(Matrix, Mid + 1, High, K, N);
    true ->
      kth_smallest_helper(Matrix, Low, Mid, K, N)
  end.

count_less_equal(Matrix, Mid, N) ->
  count_less_equal_helper(Matrix, Mid, N, N - 1, 0, 0).

count_less_equal_helper(Matrix, Mid, N, I, J, Count) ->
  if I < 0 or J >= N ->
    Count;
  true ->
    if element(I + 1, element(J + 1, Matrix)) > Mid ->
      count_less_equal_helper(Matrix, Mid, N, I - 1, J, Count);
    true ->
      count_less_equal_helper(Matrix, Mid, N, I, J + 1, Count + I + 1)
  end.
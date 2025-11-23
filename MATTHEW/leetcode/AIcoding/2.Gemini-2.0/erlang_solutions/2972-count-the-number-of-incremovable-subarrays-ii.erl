-module(solution).
-export([number_of_incremovable_subarrays/1]).

number_of_incremovable_subarrays(Nums) ->
  N = length(Nums),
  number_of_incremovable_subarrays(Nums, N, 0).

number_of_incremovable_subarrays(Nums, N, Count) ->
  number_of_incremovable_subarrays(Nums, N, 0, 0, Count).

number_of_incremovable_subarrays(Nums, N, L, Count, Acc) when L > N ->
  Acc;
number_of_incremovable_subarrays(Nums, N, L, Count, Acc) ->
  number_of_incremovable_subarrays(Nums, N, L + 1, 0, Acc + count_incremovable(Nums, L, Count, N)).

count_incremovable(Nums, L, Count, N) ->
  count_incremovable(Nums, L, 0, Count, N).

count_incremovable(Nums, L, R, Count, N) when R > L ->
  Count;
count_incremovable(Nums, L, R, Count, N) ->
  Subarray = lists:sublist(Nums, 1, R - 1) ++ lists:sublist(Nums, R + L, N - (R + L -1) +1),
  case is_increasing(Subarray) of
    true ->
      count_incremovable(Nums, L, R + 1, Count + 1, N);
    false ->
      count_incremovable(Nums, L, R + 1, Count, N)
  end.

is_increasing([]) -> true;
is_increasing([_]) -> true;
is_increasing(List) ->
  is_increasing(List, 1).

is_increasing([H1, H2 | T], _) when H1 >= H2 ->
    false;
is_increasing([_, H2 | T], _) ->
    is_increasing([H2 | T], 1);
is_increasing([_], _) ->
    true.
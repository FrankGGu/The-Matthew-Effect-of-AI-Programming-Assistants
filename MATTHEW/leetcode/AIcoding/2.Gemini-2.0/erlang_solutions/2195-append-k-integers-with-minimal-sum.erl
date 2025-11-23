-module(append_k_integers).
-export([min_sum/2]).

min_sum(Nums, K) ->
  Sorted = lists:sort(lists:usort(Nums)),
  N = length(Sorted),
  {Start, Count} = find_start_and_count(Sorted, N),
  Sum = (Start + Start + K - 1) * K div 2,
  Sum - Count * (Start + Start + Count - 1) div 2.

find_start_and_count(Sorted, N) ->
  find_start_and_count_helper(Sorted, N, 1, 0).

find_start_and_count_helper([], _, Start, Count) ->
  {Start, Count};
find_start_and_count_helper([H | T], N, Start, Count) ->
  case H of
    H when H =:= Start ->
      find_start_and_count_helper(T, N, Start + 1, Count + 1);
    _ ->
      {Start, Count}
  end.
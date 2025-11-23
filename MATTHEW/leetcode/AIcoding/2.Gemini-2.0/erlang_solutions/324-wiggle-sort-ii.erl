-module(wiggle_sort_ii).
-export([wiggle_sort/1]).

wiggle_sort(Nums) ->
  N = length(Nums),
  Mid = median(Nums),
  wiggle_sort_helper(Nums, Mid, N).

wiggle_sort_helper(Nums, Mid, N) ->
  [swap(I, new_index(I, N), Nums, Mid) || I <- lists:seq(1, N)].

swap(I, J, Nums, Mid) ->
  case should_swap(I, Nums, Mid, J) of
    true ->
      ValI = lists:nth(I, Nums),
      ValJ = lists:nth(J, Nums),
      lists:nth_replace(I, ValJ, lists:nth_replace(J, ValI, Nums));
    false ->
      Nums
  end.

should_swap(I, Nums, Mid, J) ->
  ValI = lists:nth(I, Nums),
  ValJ = lists:nth(J, Nums),
  (ValI < Mid and ValJ >= Mid) or (ValI >= Mid and ValJ < Mid).

median(Nums) ->
  sorted_nums(Nums, length(Nums) div 2 + 1).

sorted_nums(Nums, K) ->
  sorted_nums_helper(Nums, 1, length(Nums), K).

sorted_nums_helper(Nums, L, R, K) ->
  Pivot = lists:nth(L, Nums),
  {I, J} = partition(Nums, L, R, Pivot),
  case K of
    I ->
      Pivot;
    K when K < I ->
      sorted_nums_helper(Nums, L, I - 1, K);
    K ->
      sorted_nums_helper(Nums, I + 1, R, K)
  end.

partition(Nums, L, R, Pivot) ->
  {I, J, _NewNums} = partition_helper(Nums, L, L, R, Pivot),
  {I, J}.

partition_helper(Nums, L, I, R, Pivot) ->
  case I > R of
    true ->
      {I - 1, R, Nums};
    false ->
      case lists:nth(I, Nums) < Pivot of
        true ->
          ValI = lists:nth(I, Nums),
          ValL = lists:nth(L, Nums),
          NewNums = lists:nth_replace(I, ValL, lists:nth_replace(L, ValI, Nums)),
          partition_helper(NewNums, L + 1, I + 1, R, Pivot);
        false ->
          partition_helper(Nums, L, I + 1, R, Pivot)
      end
  end.

new_index(I, N) ->
  (2 * I - 1) mod (N | 1) + 1.
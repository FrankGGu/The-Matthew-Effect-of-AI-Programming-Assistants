-module(number_of_subarrays).
-export([num_subarray_bounded_max/3]).

num_subarray_bounded_max(Nums, Left, Right) ->
  num_subarray_bounded_max(Nums, Left, Right, 0, 0, 0).

num_subarray_bounded_max([], _Left, _Right, Count, _, _) ->
  Count;
num_subarray_bounded_max([H|T], Left, Right, Count, ValidCount, Start) ->
  case H of
    X when X >= Left, X =< Right ->
      num_subarray_bounded_max(T, Left, Right, Count + (Start + 1), Start + 1, Start + 1);
    X when X < Left ->
      num_subarray_bounded_max(T, Left, Right, Count, 0, 0);
    _ ->
      num_subarray_bounded_max(T, Left, Right, Count, 0, Start + 1)
  end.
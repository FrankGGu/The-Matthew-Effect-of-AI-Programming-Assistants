-module(find_target_indices).
-export([find_target_indices/2]).

find_target_indices(Nums, Target) ->
  SortedNums = lists:sort(Nums),
  find_indices(SortedNums, Target, 0, []).

find_indices([], _, _, Acc) ->
  lists:reverse(Acc);
find_indices([H|T], Target, Index, Acc) ->
  if
    H == Target ->
      find_indices(T, Target, Index + 1, [Index|Acc]);
    true ->
      find_indices(T, Target, Index + 1, Acc)
  end.
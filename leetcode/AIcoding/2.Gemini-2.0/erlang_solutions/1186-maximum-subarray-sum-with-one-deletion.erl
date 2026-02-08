-module(max_subarray_deletion).
-export([max_sub_array_deletion/1]).

max_sub_array_deletion(Nums) ->
  max_sub_array_deletion_helper(Nums, 0, 0, 0, lists:len(Nums)).

max_sub_array_deletion_helper(Nums, Index, NoDeletion, WithDeletion, Len) ->
  if Index >= Len then
    max(NoDeletion, WithDeletion)
  else
    Num = lists:nth(Index + 1, Nums),
    NewNoDeletion = max(Num, NoDeletion + Num),
    NewWithDeletion = max(NoDeletion, WithDeletion + Num),
    max(NewNoDeletion, max(NewWithDeletion, max_sub_array_deletion_helper(Nums, Index + 1, NewNoDeletion, NewWithDeletion, Len)))
  end.

max(A, B) ->
  if A > B then
    A
  else
    B
  end.
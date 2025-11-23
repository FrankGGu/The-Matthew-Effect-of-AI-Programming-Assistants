-module(reduction_operations).
-export([reduction_operations/1]).

reduction_operations(Nums) ->
  Sorted = lists:sort(Nums),
  reduction_operations_helper(Sorted, 0, []).

reduction_operations_helper([], Acc, _) ->
  Acc;
reduction_operations_helper([H|T], Acc, Seen) ->
  case lists:member(H, Seen) of
    true ->
      reduction_operations_helper(T, Acc, Seen);
    false ->
      Len = length(Seen),
      reduction_operations_helper(T, Acc + Len, [H|Seen])
  end.
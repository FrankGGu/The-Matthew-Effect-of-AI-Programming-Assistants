-module(split_array).
-export([can_split_array/2]).

can_split_array(Nums, M) ->
  Len = length(Nums),
  if Len < 3 ->
    true;
  true ->
    can_split_array_helper(Nums, M, 0, 0)
  end.

can_split_array_helper([], _, _, _) ->
  false;
can_split_array_helper([H|T], M, Sum, Count) ->
  NewSum = Sum + H,
  NewCount = Count + 1,
  if NewSum >= M ->
    if T == [] ->
      true;
    true ->
      can_split_array_helper(T, M, 0, 0) orelse can_split_array_helper(T, M, NewSum, NewCount)
    end;
  true ->
    can_split_array_helper(T, M, NewSum, NewCount)
  end.
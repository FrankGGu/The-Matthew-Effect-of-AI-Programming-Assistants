-module(delete_columns_to_make_sorted).
-export([minDeletionSize/1]).

minDeletionSize(Strs) ->
  Len = length(hd(Strs)),
  minDeletionSize(Strs, Len, 0).

minDeletionSize(_Strs, 0, Count) ->
  Count;
minDeletionSize(Strs, Len, Count) ->
  if isSorted(Strs, Len - 1) then
    minDeletionSize(Strs, Len - 1, Count)
  else
    minDeletionSize(Strs, Len - 1, Count + 1)
  end.

isSorted([], _Col) ->
  true;
isSorted([_], _Col) ->
  true;
isSorted([H1, H2 | T], Col) ->
  if H1 !! Col =< H2 !! Col then
    isSorted([H2 | T], Col)
  else
    false
  end.
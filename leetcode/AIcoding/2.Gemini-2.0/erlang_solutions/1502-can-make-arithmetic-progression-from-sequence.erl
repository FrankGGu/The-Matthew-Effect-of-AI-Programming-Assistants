-module(arithmetic_progression).
-export([can_make_arithmetic_progression/1]).

can_make_arithmetic_progression(Arr) ->
  SortedArr = lists:sort(Arr),
  Len = length(SortedArr),
  if Len < 3 then
    true
  else
    Diff = lists:nth(2, SortedArr) - lists:nth(1, SortedArr),
    can_make_arithmetic_progression_helper(SortedArr, Diff, 3)
  end.

can_make_arithmetic_progression_helper(Arr, Diff, Index) ->
  Len = length(Arr),
  if Index > Len then
    true
  else
    if lists:nth(Index, Arr) - lists:nth(Index - 1, Arr) =:= Diff then
      can_make_arithmetic_progression_helper(Arr, Diff, Index + 1)
    else
      false
    end
  end.
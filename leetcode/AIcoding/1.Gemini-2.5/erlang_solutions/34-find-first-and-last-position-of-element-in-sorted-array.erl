-module(solution).
-export([searchRange/2]).

searchRange(Nums, Target) ->
  Size = length(Nums),
  if
    Size == 0 -> [-1, -1];
    true ->
      NumsTuple = list_to_tuple(Nums),
      First = find_first(NumsTuple, Target, 0, Size - 1, -1),
      Last = find_last(NumsTuple, Target, 0, Size - 1, -1),
      [First, Last]
  end.

find_first(NumsTuple, Target, Low, High, Ans) when Low > High -> Ans;
find_first(NumsTuple, Target, Low, High, Ans) ->
  Mid = Low + (High - Low) div 2,
  Val = element(Mid + 1, NumsTuple),
  if
    Val == Target -> find_first(NumsTuple, Target, Low, Mid - 1, Mid);
    Val < Target -> find_first(NumsTuple, Target, Mid + 1, High, Ans);
    Val > Target -> find_first(NumsTuple, Target, Low, Mid - 1, Ans)
  end.

find_last(NumsTuple, Target, Low, High, Ans) when Low > High -> Ans;
find_last(NumsTuple, Target, Low, High, Ans) ->
  Mid = Low + (High - Low) div 2,
  Val = element(Mid + 1, NumsTuple),
  if
    Val == Target -> find_last(NumsTuple, Target, Mid + 1, High, Mid);
    Val < Target -> find_last(NumsTuple, Target, Mid + 1, High, Ans);
    Val > Target -> find_last(NumsTuple, Target, Low, Mid - 1, Ans)
  end.
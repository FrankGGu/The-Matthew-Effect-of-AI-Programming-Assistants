-module(minimum_average_difference).
-export([minimum_average_difference/1]).

minimum_average_difference(Nums) ->
  minimum_average_difference(Nums, 0, length(Nums) - 1, 0, 0, 16#7FFFFFFF, -1).

minimum_average_difference([H|T], Index, Len, Sum, CurrentSum, MinDifference, MinIndex) ->
  CurrentSumNew = CurrentSum + H,
  FirstAverage = floor(CurrentSumNew / (Index + 1)),
  SecondAverage =
    if Index =:= Len then
      0
    else
      RestSum = Sum - CurrentSumNew,
      floor(RestSum / (Len - Index))
    end,
  Difference = abs(FirstAverage - SecondAverage),
  if Difference < MinDifference then
    minimum_average_difference(T, Index + 1, Len, Sum, CurrentSumNew, Difference, Index)
  else
    if Index =:= Len then
      MinIndex
    else
      minimum_average_difference(T, Index + 1, Len, Sum, CurrentSumNew, MinDifference, MinIndex)
    end
  end;
minimum_average_difference([], _Index, _Len, _Sum, _CurrentSum, MinDifference, MinIndex) ->
  MinIndex.

minimum_average_difference(Nums) when is_list(Nums) ->
  Sum = lists:sum(Nums),
  minimum_average_difference(Nums, 0, length(Nums) - 1, Sum, 0, 16#7FFFFFFF, -1).
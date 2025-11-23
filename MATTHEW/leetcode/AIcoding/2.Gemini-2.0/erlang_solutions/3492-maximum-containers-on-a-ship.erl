-module(max_containers).
-export([maximumUnits/2]).

maximumUnits(BoxTypes, TruckSize) ->
  SortedBoxTypes = lists:sort(fun({UnitsA, _}, {UnitsB, _}) -> UnitsA > UnitsB end, BoxTypes),
  maximumUnitsHelper(SortedBoxTypes, TruckSize, 0).

maximumUnitsHelper([], _TruckSize, TotalUnits) ->
  TotalUnits;
maximumUnitsHelper([{UnitsPerBox, NumBoxes} | Rest], TruckSize, TotalUnits) ->
  if TruckSize >= NumBoxes then
    maximumUnitsHelper(Rest, TruckSize - NumBoxes, TotalUnits + UnitsPerBox * NumBoxes)
  else
    TotalUnits + TruckSize * UnitsPerBox
  end.
-module(maximum_units).
-export([maximum_units/2]).

maximum_units(NumOfBoxes, BoxTypes) ->
  SortedBoxTypes = lists:sort(fun({_, Units1}, {_, Units2}) -> Units1 > Units2 end, BoxTypes),
  maximum_units_helper(NumOfBoxes, SortedBoxTypes, 0).

maximum_units_helper(0, _, TotalUnits) ->
  TotalUnits;
maximum_units_helper(_, [], TotalUnits) ->
  TotalUnits;
maximum_units_helper(NumOfBoxes, [{Boxes, Units} | Rest], TotalUnits) ->
  if
    Boxes =< NumOfBoxes ->
      maximum_units_helper(NumOfBoxes - Boxes, Rest, TotalUnits + Boxes * Units);
    true ->
      maximum_units_helper(0, Rest, TotalUnits + NumOfBoxes * Units)
  end.
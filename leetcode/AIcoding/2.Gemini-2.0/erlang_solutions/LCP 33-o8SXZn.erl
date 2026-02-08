-module(solution).
-export([max_water/1]).

max_water(Height) ->
  max_water_helper(Height, 0, length(Height) - 1, 0).

max_water_helper(Height, Left, Right, MaxArea) when Left >= Right ->
  MaxArea;
max_water_helper(Height, Left, Right, MaxArea) ->
  HLeft = lists:nth(Left + 1, Height),
  HRight = lists:nth(Right + 1, Height),
  Area = min(HLeft, HRight) * (Right - Left),
  NewMaxArea = max(MaxArea, Area),
  if
    HLeft < HRight ->
      max_water_helper(Height, Left + 1, Right, NewMaxArea);
    true ->
      max_water_helper(Height, Left, Right - 1, NewMaxArea)
  end.
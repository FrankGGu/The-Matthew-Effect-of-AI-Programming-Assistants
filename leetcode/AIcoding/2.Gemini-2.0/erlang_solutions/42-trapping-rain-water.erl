-module(trapping_rain_water).
-export([trap/1]).

trap(Height) ->
  trap(Height, 0, 0, length(Height) - 1).

trap(Height, Water, Left, Right) when Left >= Right ->
  Water;
trap(Height, Water, Left, Right) ->
  LeftHeight = lists:nth(Left + 1, Height),
  RightHeight = lists:nth(Right + 1, Height),
  if LeftHeight < RightHeight ->
    LeftMax = lists:max(lists:sublist(Height, 1, Left)),
    if LeftMax > LeftHeight ->
      trap(Height, Water + (LeftMax - LeftHeight), Left + 1, Right);
    true ->
      trap(Height, Water, Left + 1, Right)
    end;
  true ->
    RightMax = lists:max(lists:sublist(Height, Right + 1, length(Height) - Right)),
    if RightMax > RightHeight ->
      trap(Height, Water + (RightMax - RightHeight), Left, Right - 1);
    true ->
      trap(Height, Water, Left, Right - 1)
    end
  end.
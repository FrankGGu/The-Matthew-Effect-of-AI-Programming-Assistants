-module(container_with_most_water).
-export([max_area/1]).

max_area(Height) ->
  max_area(Height, 0, length(Height) - 1, 0).

max_area(Height, Left, Right, MaxArea) when Left >= Right ->
  MaxArea;
max_area(Height, Left, Right, MaxArea) ->
  Area = min(lists:nth(Left + 1, Height), lists:nth(Right + 1, Height)) * (Right - Left),
  NewMaxArea = max(MaxArea, Area),
  if
    lists:nth(Left + 1, Height) < lists:nth(Right + 1, Height) ->
      max_area(Height, Left + 1, Right, NewMaxArea);
    true ->
      max_area(Height, Left, Right - 1, NewMaxArea)
  end.
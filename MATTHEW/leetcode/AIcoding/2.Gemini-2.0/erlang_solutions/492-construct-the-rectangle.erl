-module(solution).
-export([construct_rectangle/1]).

construct_rectangle(Area) ->
  {W, L} = find_dimensions(Area, trunc(math:sqrt(Area))),
  [L, W].

find_dimensions(Area, W) ->
  if W =< 0 ->
    {Area, 1};
  Area rem W =:= 0 ->
    L = Area div W,
    {L, W};
  true ->
    find_dimensions(Area, W - 1)
  end.
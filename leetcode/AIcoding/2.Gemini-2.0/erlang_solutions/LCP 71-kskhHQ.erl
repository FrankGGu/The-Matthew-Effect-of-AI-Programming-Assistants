-module(trap).
-export([trap/1]).

trap(Height) ->
  trap_helper(Height, 0, length(Height) - 1, 0).

trap_helper(Height, L, R, Area) when L >= R ->
  Area;
trap_helper(Height, L, R, Area) ->
  L_Val = lists:nth(L + 1, Height),
  R_Val = lists:nth(R + 1, Height),
  if L_Val < R_Val ->
    L_Max = lists:max(lists:sublist(Height, 1, L + 1)),
    Water = max(0, L_Max - L_Val),
    trap_helper(Height, L + 1, R, Area + Water);
  true ->
    R_Max = lists:max(lists:sublist(Height, R + 1, length(Height) - R)),
    Water = max(0, R_Max - R_Val),
    trap_helper(Height, L, R - 1, Area + Water)
  end.
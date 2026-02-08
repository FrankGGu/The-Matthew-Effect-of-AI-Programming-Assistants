-module(reachable_at_time).
-export([is_reachable/5]).

is_reachable(Sx, Sy, Fx, Fy, T) ->
  Dx = abs(Sx - Fx),
  Dy = abs(Sy - Fy),
  MaxDist = max(Dx, Dy),
  if
    MaxDist == 0 ->
      T /= 1;
    true ->
      T >= MaxDist
  end.
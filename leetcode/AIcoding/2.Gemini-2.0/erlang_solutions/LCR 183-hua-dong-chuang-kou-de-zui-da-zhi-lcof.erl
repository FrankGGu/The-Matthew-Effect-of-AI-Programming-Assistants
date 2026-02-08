-module(highest_altitude).
-export([solve/1]).

solve(gain) ->
  solve(gain, 0, 0, 0).

solve([], Current, Max, _Index) ->
  max(Current, Max);
solve([G|Rest], Current, Max, Index) ->
  NewCurrent = Current + G,
  NewMax = max(NewCurrent, Max),
  solve(Rest, NewCurrent, NewMax, Index + 1).
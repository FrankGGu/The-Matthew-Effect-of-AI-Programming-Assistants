-module(solution).
-export([max_distance/1]).

max_distance(List) ->
    max_distance(List, 0, 0, 0, length(List)).

max_distance([], _, _, MaxDistance, _) ->
    MaxDistance;
max_distance([H | T], Min, Max, MaxDistance, Length) ->
    NewMin = if Min == 0 orelse H < Min -> H; true -> Min end,
    NewMax = if H > Max -> H; true -> Max end,
    NewMaxDistance = if Min =:= 0 orelse NewMin =:= NewMax -> MaxDistance; true -> max(MaxDistance, Max - NewMin) end,
    max_distance(T, NewMin, NewMax, NewMaxDistance, Length).
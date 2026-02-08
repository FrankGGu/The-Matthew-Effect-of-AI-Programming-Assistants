-module(highest_altitude).
-export([largest_altitude/1]).

largest_altitude(Gains) ->
    largest_altitude(Gains, 0, 0).

largest_altitude([], Current, Max) ->
    Max;
largest_altitude([G | Gains], Current, Max) ->
    NewCurrent = Current + G,
    NewMax = if
        NewCurrent > Max -> NewCurrent;
        true -> Max
    end,
    largest_altitude(Gains, NewCurrent, NewMax).
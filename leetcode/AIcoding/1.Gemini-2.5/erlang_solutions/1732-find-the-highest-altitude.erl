-module(solution).
-export([largest_altitude/1]).

largest_altitude(Gain) ->
    largest_altitude(Gain, 0, 0).

largest_altitude([], _CurrentAltitude, MaxAltitude) ->
    MaxAltitude;
largest_altitude([H|T], CurrentAltitude, MaxAltitude) ->
    NewCurrentAltitude = CurrentAltitude + H,
    NewMaxAltitude = max(MaxAltitude, NewCurrentAltitude),
    largest_altitude(T, NewCurrentAltitude, NewMaxAltitude).
-module(highest_altitude).
-export([largestAltitude/1]).

largestAltitude(Gain) ->
    largestAltitude(Gain, 0, 0).

largestAltitude([], Current, Max) ->
    max(Current, Max);
largestAltitude([G | Rest], Current, Max) ->
    NewCurrent = Current + G,
    largestAltitude(Rest, NewCurrent, max(NewCurrent, Max)).
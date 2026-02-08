-module(slowest_key).
-export([slowest_key/1]).

slowest_key(Keys) ->
    slowest_key(Keys, 0, 0, $a).

slowest_key([], _, MaxTime, Char) ->
    Char;
slowest_key([{Key, Time} | Rest], PrevTime, MaxTime, Char) ->
    CurrentTime = Time - PrevTime,
    if
        CurrentTime > MaxTime ->
            slowest_key(Rest, Time, CurrentTime, Key);
        CurrentTime == MaxTime ->
            slowest_key(Rest, Time, CurrentTime, min(Key, Char));
        true ->
            slowest_key(Rest, Time, MaxTime, Char)
    end.
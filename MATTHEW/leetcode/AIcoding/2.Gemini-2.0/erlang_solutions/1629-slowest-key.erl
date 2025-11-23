-module(slowest_key).
-export([slowestKey/1]).

slowestKey(R) ->
    slowestKey(R, 0, 0, $a).

slowestKey([], _, MaxDuration, MaxChar) ->
    MaxChar;
slowestKey([H|T], PrevTime, MaxDuration, MaxChar) ->
    [Time, Char] = H,
    Duration = Time - PrevTime,
    if
        Duration > MaxDuration ->
            slowestKey(T, Time, Duration, Char);
        Duration == MaxDuration andalso Char > MaxChar ->
            slowestKey(T, Time, Duration, Char);
        true ->
            slowestKey(T, Time, MaxDuration, MaxChar)
    end.
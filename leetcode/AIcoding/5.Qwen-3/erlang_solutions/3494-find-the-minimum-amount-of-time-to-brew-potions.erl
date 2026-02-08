-module(solution).
-export([minimum_time/1]).

minimum_time(Potions) ->
    minimum_time(Potions, 0, 0).

minimum_time([], _, Time) ->
    Time;
minimum_time([H | T], CurrentTime, Time) ->
    if
        H =< CurrentTime ->
            minimum_time(T, CurrentTime + 1, Time + 1);
        true ->
            minimum_time(T, H, Time + H)
    end.
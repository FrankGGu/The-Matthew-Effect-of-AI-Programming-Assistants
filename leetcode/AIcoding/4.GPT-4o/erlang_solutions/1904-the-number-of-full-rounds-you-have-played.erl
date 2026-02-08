-module(solution).
-export([numberOfRounds/2]).

numberOfRounds(StartTime, EndTime) ->
    Start = parse_time(StartTime),
    End = parse_time(EndTime),
    if
        End < Start -> 
            End + 24 * 60 - Start;
        true ->
            End - Start
    end div 15.

parse_time(Time) ->
    [H, M] = string:tokens(Time, ":"),
    list_to_integer(H) * 60 + list_to_integer(M).
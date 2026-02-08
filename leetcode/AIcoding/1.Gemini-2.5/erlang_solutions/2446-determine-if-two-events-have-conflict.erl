-module(solution).
-export([hasConflict/2]).

to_minutes([H1, H2, $:, M1, M2]) ->
    H = list_to_integer([H1, H2]),
    M = list_to_integer([M1, M2]),
    H * 60 + M.

hasConflict(Event1, Event2) ->
    [Start1Str, End1Str] = Event1,
    [Start2Str, End2Str] = Event2,

    Start1 = to_minutes(Start1Str),
    End1 = to_minutes(End1Str),
    Start2 = to_minutes(Start2Str),
    End2 = to_minutes(End2Str),

    (Start1 =< End2) andalso (Start2 =< End1).
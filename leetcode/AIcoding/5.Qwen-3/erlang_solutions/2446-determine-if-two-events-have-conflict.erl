-module(solution).
-export([have_conflict/2]).

have_conflict(Event1, Event2) ->
    [A1, A2] = Event1,
    [B1, B2] = Event2,
    not (A2 < B1 or B2 < A1).
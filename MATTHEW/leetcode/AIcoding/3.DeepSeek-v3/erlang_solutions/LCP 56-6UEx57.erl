-module(solution).
-export([deliver_message/2]).

deliver_message(Start, End) ->
    StartX = element(1, Start),
    StartY = element(2, Start),
    EndX = element(1, End),
    EndY = element(2, End),
    DX = abs(EndX - StartX),
    DY = abs(EndY - StartY),
    max(DX, DY).
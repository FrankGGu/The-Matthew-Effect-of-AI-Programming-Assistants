-module(solution).
-export([isReachableAtTime/5]).

isReachableAtTime(Sx, Sy, Tx, Ty, T) ->
    Dx = erlang:abs(Tx - Sx),
    Dy = erlang:abs(Ty - Sy),
    MinDist = erlang:max(Dx, Dy),

    if
        MinDist == 0 ->
            T =/= 1;
        true ->
            T >= MinDist
    end.
-module(solution).
-export([min_moves/2]).

min_moves(P, Q) ->
    Px = lists:nth(1, P),
    Py = lists:nth(2, P),
    Qx = lists:nth(1, Q),
    Qy = lists:nth(2, Q),
    case {abs(Px - Qx), abs(Py - Qy)} of
        {0, _} -> 1;
        {_, 0} -> 1;
        {D, D} -> 1;
        _ -> 2
    end.
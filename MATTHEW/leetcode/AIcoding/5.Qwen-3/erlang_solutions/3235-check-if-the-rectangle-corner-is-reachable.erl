-module(solution).
-export([is_reachable/2]).

is_reachable(X, Y) ->
    is_reachable(X, Y, 0, 0, 1, 1).

is_reachable(X, Y, X1, Y1, DX, DY) ->
    if
        X1 == X andalso Y1 == Y -> true;
        X1 > X orelse Y1 > Y -> false;
        true ->
            case rand:uniform(2) of
                1 -> is_reachable(X, Y, X1 + DX, Y1, DX, DY);
                2 -> is_reachable(X, Y, X1, Y1 + DY, DX, DY)
            end
    end.
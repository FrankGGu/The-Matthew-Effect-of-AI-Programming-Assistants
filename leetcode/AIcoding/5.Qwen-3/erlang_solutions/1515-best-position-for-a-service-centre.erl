-module(solution).
-export([best_position/1]).

best_position(Coords) ->
    best_position(Coords, 0, 0, 0, 0, 0, 0).

best_position([], X, Y, Min, _X, _Y, Count) ->
    {X div Count, Y div Count};

best_position([[X, Y] | T], CX, CY, Min, X0, Y0, Count) ->
    best_position(T, CX + X, CY + Y, Min, X, Y, Count + 1);

best_position([[X, Y] | T], CX, CY, Min, X0, Y0, Count) ->
    Dist = abs(X - X0) + abs(Y - Y0),
    if
        Dist < Min ->
            best_position(T, CX + X, CY + Y, Dist, X, Y, Count + 1);
        true ->
            best_position(T, CX, CY, Min, X0, Y0, Count)
    end.
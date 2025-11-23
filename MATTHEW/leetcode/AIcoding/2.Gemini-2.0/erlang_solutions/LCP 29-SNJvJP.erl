-module(band_position).
-export([solve/1]).

solve(N) ->
    X = N - 1,
    Level = min(X, min(10000 - X, min(10000 - X, X))),
    Offset = X - Level,
    SideLength = 10000 - 2 * Level,

    if Offset < SideLength then
        (Level + Offset + 1) rem 10 + 1
    else if Offset < 2 * SideLength then
        (Level + SideLength + (Offset - SideLength) + 1) rem 10 + 1
    else if Offset < 3 * SideLength then
        (Level + 2 * SideLength + (Offset - 2 * SideLength) + 1) rem 10 + 1
    else
        (Level + 3 * SideLength + (Offset - 3 * SideLength) + 1) rem 10 + 1
    end.
-module(solution).
-export([numMovesStones/3]).

numMovesStones(A, B, C) ->
    Sorted = lists:sort([A, B, C]),
    [X, Y, Z] = Sorted,

    MinMoves =
        if
            Z - X == 2 -> 0;
            Y - X <= 2 orelse Z - Y <= 2 -> 1;
            true -> 2
        end,

    MaxMoves = (Y - X - 1) + (Z - Y - 1),

    [MinMoves, MaxMoves].
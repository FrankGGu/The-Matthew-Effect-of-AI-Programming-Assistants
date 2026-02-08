-module(solution).
-export([orchestraSeats/3]).

orchestraSeats(N, X, Y) ->
    % Calculate the distance from the current cell (X, Y) to each of the four borders.
    % X and Y are 1-indexed.
    DistToTop = X - 1,
    DistToLeft = Y - 1,
    DistToBottom = N - X,
    DistToRight = N - Y,

    % The value at cell (X, Y) is 1 plus the minimum of these four distances.
    MinDist = min(DistToTop, min(DistToLeft, min(DistToBottom, DistToRight))),

    MinDist + 1.
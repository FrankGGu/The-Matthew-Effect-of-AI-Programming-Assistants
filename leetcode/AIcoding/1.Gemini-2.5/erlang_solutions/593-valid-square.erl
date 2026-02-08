-module(solution).
-export([valid_square/4]).

dist_sq([X1, Y1], [X2, Y2]) ->
    DX = X2 - X1,
    DY = Y2 - Y1,
    DX*DX + DY*DY.

valid_square(P1, P2, P3, P4) ->
    Dists = [
        dist_sq(P1, P2),
        dist_sq(P1, P3),
        dist_sq(P1, P4),
        dist_sq(P2, P3),
        dist_sq(P2, P4),
        dist_sq(P3, P4)
    ],
    SortedDists = lists:sort(Dists),
    case SortedDists of
        [S, S, S, S, D, D] when S > 0, D =:= 2 * S ->
            true;
        _ ->
            false
    end.
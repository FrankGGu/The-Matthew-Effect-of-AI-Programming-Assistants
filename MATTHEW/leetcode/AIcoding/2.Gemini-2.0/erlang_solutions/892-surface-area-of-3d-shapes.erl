-module(surface_area).
-export([surface_area/1]).

surface_area(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    surface_area(Grid, N, M, 0).

surface_area(_, 0, _, Acc) -> Acc;
surface_area(Grid, N, M, Acc) ->
    surface_area(Grid, N - 1, M, surface_area_row(Grid, N - 1, M, Acc)).

surface_area_row(_, _, 0, Acc) -> Acc;
surface_area_row(Grid, N, M, Acc) ->
    surface_area_row(Grid, N, M - 1, Acc + surface_area_cell(Grid, N, M - 1)).

surface_area_cell(Grid, N, M) ->
    Z = lists:nth(M + 1, lists:nth(N + 1, Grid)),
    if
        Z > 0 ->
            2 * Z +
            (if N > 0 -> max(0, Z - lists:nth(M + 1, lists:nth(N, Grid))) else Z end) +
            (if N < length(Grid) - 1 -> max(0, Z - lists:nth(M + 1, lists:nth(N + 2, Grid))) else Z end) +
            (if M > 0 -> max(0, Z - lists:nth(M, lists:nth(N + 1, Grid))) else Z end) +
            (if M < length(hd(Grid)) - 1 -> max(0, Z - lists:nth(M + 2, lists:nth(N + 1, Grid))) else Z end);
        true ->
            0
    end.
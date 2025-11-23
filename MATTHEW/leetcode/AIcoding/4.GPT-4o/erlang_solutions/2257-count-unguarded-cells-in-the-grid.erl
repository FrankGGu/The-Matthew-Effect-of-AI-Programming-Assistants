-module(solution).
-export([count_unguarded_cells/3]).

count_unguarded_cells(N, M, guards) ->
    Grid = lists:duplicate(N, lists:duplicate(M, 0)),
    Grid1 = lists:foldl(fun({X, Y}, Acc) ->
        set_guarded(Acc, X, Y, N, M)
    end, Grid, guards),
    count_unguarded(Grid1).

set_guarded(Grid, X, Y, N, M) ->
    Guarded1 = set_cell(Grid, X, Y),
    Guarded2 = set_row(Guarded1, X, Y, M),
    Guarded3 = set_col(Guarded2, X, Y, N),
    Guarded3.

set_cell(Grid, X, Y) ->
    lists:update_element(X + 1, lists:update_element(Y + 1, 1, lists:nth(X + 1, Grid)), Grid).

set_row(Grid, X, Y, M) ->
    lists:foldl(fun(J, Acc) ->
        set_cell(Acc, X, J)
    end, Grid, lists:seq(1, M)).

set_col(Grid, X, Y, N) ->
    lists:foldl(fun(I, Acc) ->
        set_cell(Acc, I, Y)
    end, Grid, lists:seq(1, N)).

count_unguarded(Grid) ->
    lists:foldl(fun(Row, Acc) ->
        Acc + lists:foldl(fun(Cell, Acc2) ->
            Acc2 + (if Cell == 0 -> 1; true -> 0 end)
        end, 0, Row)
    end, 0, Grid).
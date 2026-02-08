-module(solution).
-export([diff_between_ones_and_zeros_in_row_and_column/1]).

diff_between_ones_and_zeros_in_row_and_column(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    OnesRow = [lists:sum(Row) || Row <- Grid],

    InitialOnesCol = lists:duplicate(N, 0),
    OnesCol = lists:foldl(fun(Row, AccOnesCol) ->
                                lists:zipwith(fun(GridVal, ColSum) -> GridVal + ColSum end, Row, AccOnesCol)
                          end, InitialOnesCol, Grid),

    [ [ 2*OnesR + 2*OnesC - N - M || OnesC <- OnesCol ] || OnesR <- OnesRow ].
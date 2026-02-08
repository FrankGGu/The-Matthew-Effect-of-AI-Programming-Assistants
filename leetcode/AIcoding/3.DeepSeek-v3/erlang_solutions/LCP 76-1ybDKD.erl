-module(solution).
-export([magicalBoard/1]).

magicalBoard(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    RowMagic = lists:all(fun(Row) -> lists:sum(Row) == lists:sum(hd(Board)) end, Board),
    ColMagic = lists:all(fun(C) ->
        ColSum = lists:sum([lists:nth(C, Row) || Row <- Board]),
        ColSum == lists:sum(hd(Board))
    end, lists:seq(1, Cols)),
    Diag1 = lists:sum([lists:nth(I, lists:nth(I, Board)) || I <- lists:seq(1, min(Rows, Cols))]),
    Diag2 = lists:sum([lists:nth(Cols - I + 1, lists:nth(I, Board)) || I <- lists:seq(1, min(Rows, Cols))]),
    DiagMagic = (Diag1 == Diag2) and (Diag1 == lists:sum(hd(Board))),
    Unique = lists:usort(lists:flatten(Board)) == lists:seq(1, Rows * Cols),
    RowMagic and ColMagic and DiagMagic and Unique.
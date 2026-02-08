-module(solution).
-export([magicSquareInGrid/1]).

magicSquareInGrid(Grid) ->
    R = length(Grid),
    C = length(hd(Grid)),

    if R < 3; C < 3 ->
        0;
    true ->
        lists:foldl(fun(RowIdx, Acc1) ->
            lists:foldl(fun(ColIdx, Acc2) ->
                Subgrid = get_subgrid(Grid, RowIdx, ColIdx),
                case is_magic_square(Subgrid) of
                    true -> Acc2 + 1;
                    false -> Acc2
                end
            end, Acc1, lists:seq(0, C - 3))
        end, 0, lists:seq(0, R - 3))
    end.

get_subgrid(Grid, StartRow, StartCol) ->
    RowsAfterDrop = lists:drop(StartRow, Grid),
    [R1, R2, R3 | _] = RowsAfterDrop,

    [
        lists:take(3, lists:drop(StartCol, R1)),
        lists:take(3, lists:drop(StartCol, R2)),
        lists:take(3, lists:drop(StartCol, R3))
    ].

is_magic_square(Subgrid) ->
    [
        [A, B, C],
        [D, E, F],
        [G, H, I]
    ] = Subgrid,

    Numbers = [A, B, C, D, E, F, G, H, I],

    SortedNumbers = lists:sort(Numbers),

    if SortedNumbers /= [1,2,3,4,5,6,7,8,9] ->
        false;
    true ->
        Sum = 15,
        (A+B+C == Sum) and
        (D+E+F == Sum) and
        (G+H+I == Sum) and
        (A+D+G == Sum) and
        (B+E+H == Sum) and
        (C+F+I == Sum) and
        (A+E+I == Sum) and
        (C+E+G == Sum)
    end.
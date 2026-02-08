-module(magic_squares_in_grid).
-export([num_magic_squares/1]).

num_magic_squares(Grid) ->
    Count = 0,
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    num_magic_squares(Grid, 0, 0, Rows, Cols, Count).

num_magic_squares(_, R, C, Rows, Cols, Count) when R + 2 >= Rows; C + 2 >= Cols ->
    Count;
num_magic_squares(Grid, R, C, Rows, Cols, Count) ->
    SubGrid = [
        lists:nth(R+1, Grid),
        lists:nth(R+2, Grid),
        lists:nth(R+3, Grid)
    ],
    SubGridValues = [
        lists:nth(C+1, SubGrid),
        lists:nth(C+2, SubGrid),
        lists:nth(C+3, SubGrid)
    ],
    case is_magic(SubGridValues) of
        true -> num_magic_squares(Grid, R, C+1, Rows, Cols, Count + 1);
        false -> num_magic_squares(Grid, R, C+1, Rows, Cols, Count)
    end.

is_magic([[A,B,C],[D,E,F],[G,H,I]]) ->
    Sums = [A+B+C, D+E+F, G+H+I, A+D+G, B+E+H, C+F+I, A+E+I, C+E+G],
    lists:all(fun(Sum) -> Sum == hd(Sums) end, Sums),
    Unique = lists:usort([A,B,C,D,E,F,G,H,I]),
    length(Unique) == 9,
    lists:member(1, Unique) andalso lists:member(9, Unique);
is_magic(_) ->
    false.
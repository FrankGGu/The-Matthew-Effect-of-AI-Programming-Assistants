-module(largest_magic_square).
-export([magic_square/1]).

magic_square(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    MaxSize = 1,
    find_max_size(Grid, Rows, Cols, MaxSize).

find_max_size(_, _, Cols, MaxSize) when Cols =< 1 -> MaxSize;
find_max_size(Grid, Rows, Cols, MaxSize) ->
    NewMax = check_all_squares(Grid, Rows, Cols, MaxSize),
    find_max_size(Grid, Rows, Cols - 1, NewMax).

check_all_squares(_, _, Cols, MaxSize) when Cols =< 1 -> MaxSize;
check_all_squares(Grid, Rows, Cols, MaxSize) ->
    NewMax = check_all_positions(Grid, Rows, Cols, MaxSize),
    check_all_squares(Grid, Rows, Cols - 1, NewMax).

check_all_positions(_, Rows, _, MaxSize) when Rows =< 1 -> MaxSize;
check_all_positions(Grid, Rows, Cols, MaxSize) ->
    NewMax = check_positions(Grid, 0, 0, Rows, Cols, MaxSize),
    check_all_positions(Grid, Rows - 1, Cols, NewMax).

check_positions(_, X, Y, Rows, Cols, MaxSize) when X >= Rows -> MaxSize;
check_positions(Grid, X, Y, Rows, Cols, MaxSize) ->
    NewMax = check_position(Grid, X, Y, Rows, Cols, MaxSize),
    check_positions(Grid, X + 1, Y, Rows, Cols, NewMax).

check_position(_, X, Y, Rows, Cols, MaxSize) when Y >= Cols -> MaxSize;
check_position(Grid, X, Y, Rows, Cols, MaxSize) ->
    MaxPossible = min(Rows - X, Cols - Y),
    NewMax = check_possible_size(Grid, X, Y, MaxPossible, MaxSize),
    check_position(Grid, X, Y + 1, Rows, Cols, NewMax).

check_possible_size(_, _, _, 0, MaxSize) -> MaxSize;
check_possible_size(Grid, X, Y, Size, MaxSize) ->
    if
        is_magic_square(Grid, X, Y, Size) ->
            max(Size, MaxSize);
        true ->
            check_possible_size(Grid, X, Y, Size - 1, MaxSize)
    end.

is_magic_square(Grid, X, Y, Size) ->
    Sum = magic_sum(Grid, X, Y, Size),
    check_rows(Grid, X, Y, Size, Sum) andalso
    check_cols(Grid, X, Y, Size, Sum) andalso
    check_diags(Grid, X, Y, Size, Sum).

magic_sum(Grid, X, Y, Size) ->
    RowSum = lists:sum(lists:nth(X + 1, Grid), Y, Y + Size - 1),
    RowSum.

lists:nth(Index, List) ->
    lists:nth(Index, List).

lists:nth(Index, List, Start, End) ->
    lists:sublist(List, Start + 1, End - Start + 1).

check_rows(_, _, _, 0, _) -> true;
check_rows(Grid, X, Y, Size, Sum) ->
    Row = lists:nth(X + 1, Grid),
    RowSum = lists:sum(lists:nth(Row, Y, Y + Size - 1)),
    if
        RowSum == Sum ->
            check_rows(Grid, X + 1, Y, Size - 1, Sum);
        true ->
            false
    end.

check_cols(_, _, _, 0, _) -> true;
check_cols(Grid, X, Y, Size, Sum) ->
    ColSum = 0,
    for I <- 0 to Size - 1 do
        ColSum = ColSum + lists:nth(X + I + 1, Grid, Y + 1, Y + 1)
    end,
    if
        ColSum == Sum ->
            check_cols(Grid, X, Y + 1, Size - 1, Sum);
        true ->
            false
    end.

check_diags(_, _, _, 0, _) -> true;
check_diags(Grid, X, Y, Size, Sum) ->
    Diag1 = 0,
    for I <- 0 to Size - 1 do
        Diag1 = Diag1 + lists:nth(X + I + 1, Grid, Y + I + 1, Y + I + 1)
    end,
    Diag2 = 0,
    for I <- 0 to Size - 1 do
        Diag2 = Diag2 + lists:nth(X + I + 1, Grid, Y + (Size - 1 - I) + 1, Y + (Size - 1 - I) + 1)
    end,
    Diag1 == Sum andalso Diag2 == Sum.
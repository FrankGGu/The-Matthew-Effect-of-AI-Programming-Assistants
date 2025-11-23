-module(equale_sum_grid_partition_i).
-export([is_possible/1]).

is_possible(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Sum = lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun(Num, A) -> A + Num end, Acc, Row)
    end, 0, Grid),
    case Sum rem 2 of
        0 -> check_partition(Grid, Rows, Cols, Sum div 2, 0, 0);
        _ -> false
    end.

check_partition(Grid, Rows, Cols, Target, R, C) ->
    if
        R == Rows -> false;
        C == Cols -> check_partition(Grid, Rows, Cols, Target, R+1, 0);
        true ->
            Current = lists:nth(R+1, Grid) -- [0] -- [lists:nth(C+1, lists:nth(R+1, Grid))],
            NewTarget = Target - lists:nth(C+1, lists:nth(R+1, Grid)),
            case NewTarget of
                0 -> true;
                _ ->
                    case check_partition(Grid, Rows, Cols, NewTarget, R, C+1) of
                        true -> true;
                        _ ->
                            check_partition(Grid, Rows, Cols, Target, R, C+1)
                    end
            end
    end.
-module(pacific_atlantic_water_flow).
-export([compute/1]).

compute(Height) ->
    Rows = length(Height),
    if
        Rows == 0 -> [];
        true ->
            Cols = length(hd(Height)),
            Pacific = [[false || _ <- lists:seq(1, Cols)] || _ <- lists:seq(1, Rows)],
            Atlantic = [[false || _ <- lists:seq(1, Cols)] || _ <- lists:seq(1, Rows)],
            flow(Pacific, Atlantic, Height, Rows, Cols, fun is_pacific/3),
            flow(Atlantic, Pacific, Height, Rows, Cols, fun is_atlantic/3),
            collect(Pacific, Atlantic, Height, Rows, Cols)
    end.

flow(_, _, _, _, _, _) -> ok;
flow(Grid1, Grid2, Height, Rows, Cols, Fun) ->
    [flow_row(Grid1, Grid2, Height, Rows, Cols, Fun, I) || I <- lists:seq(1, Rows)],
    [flow_col(Grid1, Grid2, Height, Rows, Cols, Fun, J) || J <- lists:seq(1, Cols)].

flow_row(_, _, _, _, _, _, _) -> ok;
flow_row(Grid1, Grid2, Height, Rows, Cols, Fun, I) ->
    [flow_cell(Grid1, Grid2, Height, Rows, Cols, Fun, I, J) || J <- lists:seq(1, Cols)].

flow_col(_, _, _, _, _, _, _, _) -> ok;
flow_col(Grid1, Grid2, Height, Rows, Cols, Fun, J) ->
    [flow_cell(Grid1, Grid2, Height, Rows, Cols, Fun, I, J) || I <- lists:seq(1, Rows)].

flow_cell(Grid1, Grid2, Height, Rows, Cols, Fun, I, J) ->
    case Fun(I, J, Grid1) of
        true -> ok;
        false ->
            case Fun(I, J, Grid2) of
                true -> ok;
                false ->
                    case is_valid(I, J, Rows, Cols) of
                        true ->
                            Val = lists:nth(I, Height),
                            Current = lists:nth(J, Val),
                            [check_neighbor(Grid1, Grid2, Height, Rows, Cols, Fun, I, J, I + 1, J),
                             check_neighbor(Grid1, Grid2, Height, Rows, Cols, Fun, I, J, I - 1, J),
                             check_neighbor(Grid1, Grid2, Height, Rows, Cols, Fun, I, J, I, J + 1),
                             check_neighbor(Grid1, Grid2, Height, Rows, Cols, Fun, I, J, I, J - 1)];
                        false -> ok
                    end
            end
    end.

check_neighbor(Grid1, Grid2, Height, Rows, Cols, Fun, I, J, NI, NJ) ->
    case is_valid(NI, NJ, Rows, Cols) of
        true ->
            NVal = lists:nth(NI, Height),
            NCurrent = lists:nth(NJ, NVal),
            if
                Current =< NCurrent ->
                    case Fun(NI, NJ, Grid1) of
                        true -> ok;
                        false ->
                            case Fun(NI, NJ, Grid2) of
                                true -> ok;
                                false -> update(Grid1, Grid2, Fun, NI, NJ)
                            end
                    end;
                true -> ok
            end;
        false -> ok
    end.

update(Grid1, Grid2, Fun, I, J) ->
    case Fun(I, J, Grid1) of
        true -> ok;
        false ->
            case Fun(I, J, Grid2) of
                true -> ok;
                false ->
                    case Fun(I, J, Grid1) of
                        true -> ok;
                        false -> set(Grid1, I, J, true)
                    end
            end
    end.

set(Grid, I, J, Val) ->
    Row = lists:nth(I, Grid),
    NewRow = lists:sublist(Row, J - 1) ++ [Val] ++ lists:sublist(Row, J, length(Row) - J + 1),
    lists:sublist(Grid, I - 1) ++ [NewRow] ++ lists:sublist(Grid, I, length(Grid) - I + 1).

is_valid(I, J, Rows, Cols) ->
    I >= 1 andalso I =< Rows andalso J >= 1 andalso J =< Cols.

is_pacific(I, J, Grid) ->
    lists:nth(I, Grid) -- [J] -- [true].

is_atlantic(I, J, Grid) ->
    lists:nth(I, Grid) -- [J] -- [true].

collect(Pacific, Atlantic, Height, Rows, Cols) ->
    [lists:foldl(fun(J, Acc) ->
                         if
                             lists:nth(I, Pacific) -- [J] -- [true] andalso lists:nth(I, Atlantic) -- [J] -- [true] ->
                                 [{I-1, J-1} | Acc];
                             true -> Acc
                         end
                 end, [], lists:seq(1, Cols))
     || I <- lists:seq(1, Rows)].
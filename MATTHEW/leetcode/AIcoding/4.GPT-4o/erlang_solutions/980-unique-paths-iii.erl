-module(unique_paths_iii).
-export([unique_paths_iii/1]).

unique_paths_iii(Grid) ->
    {Start, End, EmptyCount} = find_positions(Grid, 0, 0, 0),
    paths(Start, End, Grid, EmptyCount + 1).

find_positions([], _, _, EmptyCount) ->
    {undefined, undefined, EmptyCount};
find_positions([Row | Rest], RowIndex, ColIndex, EmptyCount) ->
    find_positions_in_row(Row, RowIndex, ColIndex, Rest, 0, EmptyCount).

find_positions_in_row([], _, _, _, _, EmptyCount) ->
    find_positions([], 0, 0, EmptyCount);
find_positions_in_row([0 | Rest], RowIndex, ColIndex, AllRest, ColIndexInRow, EmptyCount) ->
    find_positions_in_row(Rest, RowIndex, ColIndex + 1, AllRest, ColIndexInRow + 1, EmptyCount + 1);
find_positions_in_row([1 | Rest], RowIndex, ColIndex, AllRest, ColIndexInRow, EmptyCount) ->
    {StartX, StartY} = {RowIndex, ColIndex},
    find_positions_in_row(Rest, RowIndex, ColIndex + 1, AllRest, ColIndexInRow + 1, EmptyCount);
find_positions_in_row([2 | Rest], RowIndex, ColIndex, AllRest, ColIndexInRow, EmptyCount) ->
    {EndX, EndY} = {RowIndex, ColIndex},
    find_positions_in_row(Rest, RowIndex, ColIndex + 1, AllRest, ColIndexInRow + 1, EmptyCount);
find_positions_in_row([_ | Rest], RowIndex, ColIndex, AllRest, ColIndexInRow, EmptyCount) ->
    find_positions_in_row(Rest, RowIndex, ColIndex + 1, AllRest, ColIndexInRow + 1, EmptyCount).

paths({StartX, StartY}, {EndX, EndY}, Grid, VisitableCount) ->
    paths(StartX, StartY, EndX, EndY, Grid, VisitableCount, []).

paths(X, Y, EndX, EndY, Grid, VisitableCount, Visited) when X == EndX, Y == EndY, length(Visited) == VisitableCount ->
    1;
paths(X, Y, EndX, EndY, Grid, VisitableCount, Visited) when X == EndX, Y == EndY ->
    0;
paths(X, Y, EndX, EndY, Grid, VisitableCount, Visited) ->
    case valid_move(X, Y, Grid, Visited) of
        true ->
            paths(X, Y + 1, EndX, EndY, Grid, VisitableCount, [{X, Y} | Visited]) +
            paths(X + 1, Y, EndX, EndY, Grid, VisitableCount, [{X, Y} | Visited]) +
            paths(X, Y - 1, EndX, EndY, Grid, VisitableCount, [{X, Y} | Visited]) +
            paths(X - 1, Y, EndX, EndY, Grid, VisitableCount, [{X, Y} | Visited]);
        false ->
            0
    end.

valid_move(X, Y, Grid, Visited) ->
    X >= 0, Y >= 0, 
    case lists:nth(X + 1, Grid) of
        Row when is_list(Row) ->
            Y < length(Row) andalso 
            (lists:nth(Y + 1, Row) == 0 orelse lists:nth(Y + 1, Row) == 2) andalso 
            not lists:member({X, Y}, Visited);
        _ -> false
    end.
-module(max_area_of_island).
-export([max_area/1]).

max_area(Grid) ->
    MaxArea = lists:foldl(fun(Row, Acc) -> 
        MaxAreaRow = max_area_row(Row, Grid), 
        max(Acc, MaxAreaRow) 
    end, 0, lists:seq(1, length(Grid))),
    MaxArea.

max_area_row(RowIndex, Grid) ->
    case lists:nth(RowIndex, Grid) of
        [] -> 0;
        Row -> 
            Area = count_area(Row, RowIndex, Grid, lists:duplicate(length(Row), false)),
            Area
    end.

count_area([], _, _, _) -> 0;
count_area([0 | T], RowIndex, Grid, Visited) -> 
    count_area(T, RowIndex, Grid, Visited);
count_area([1 | T], RowIndex, Grid, Visited) -> 
    Visited1 = lists:replace_element(RowIndex, Visited, true),
    1 + count_neighbours(RowIndex, Visited1, Grid) + count_area(T, RowIndex, Grid, Visited1).

count_neighbours(RowIndex, Visited, Grid) ->
    count_neighbour(RowIndex, Visited, Grid, -1) + count_neighbour(RowIndex, Visited, Grid, 1) +
    count_neighbour(RowIndex, Visited, Grid, 0).

count_neighbour(RowIndex, Visited, Grid, Offset) ->
    NewRowIndex = RowIndex + Offset,
    case lists:nth(NewRowIndex, Grid) of
        [] -> 0;
        NewRow -> 
            count_area(NewRow, NewRowIndex, Grid, Visited)
    end.
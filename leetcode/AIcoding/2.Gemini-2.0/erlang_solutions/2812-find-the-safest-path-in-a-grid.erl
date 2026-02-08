-module(safest_path).
-export([maximum_safeness_factor/1]).

maximum_safeness_factor(Grid) ->
    {Rows, Cols} = grid_size(Grid),
    Bombs = find_bombs(Grid, Rows, Cols),
    Distances = calculate_distances(Rows, Cols, Bombs),
    PathDistances = dijkstra(Distances, Rows, Cols),
    min(lists:nth(1, lists:nth(Rows, PathDistances)), lists:nth(Cols, lists:nth(1, PathDistances))).

grid_size(Grid) ->
    {length(Grid), length(lists:nth(1, Grid))}.

find_bombs(Grid, Rows, Cols) ->
    find_bombs_helper(Grid, Rows, Cols, 1, 1, []).

find_bombs_helper(_Grid, Rows, Cols, Row, Col, Acc) when Row > Rows ->
    lists:reverse(Acc);
find_bombs_helper(Grid, Rows, Cols, Row, Col, Acc) ->
    if
        lists:nth(Col, lists:nth(Row, Grid)) == 1 ->
            NewAcc = [{Row, Col} | Acc];
            if
                Col == Cols ->
                    find_bombs_helper(Grid, Rows, Cols, Row + 1, 1, NewAcc);
                true ->
                    find_bombs_helper(Grid, Rows, Cols, Row, Col + 1, NewAcc)
            end;
        true ->
            if
                Col == Cols ->
                    find_bombs_helper(Grid, Rows, Cols, Row + 1, 1, Acc);
                true ->
                    find_bombs_helper(Grid, Rows, Cols, Row, Col + 1, Acc)
            end
    end.

calculate_distances(Rows, Cols, Bombs) ->
    calculate_distances_helper(Rows, Cols, Bombs, []).

calculate_distances_helper(Rows, Cols, Bombs, Acc) when length(Acc) == Rows ->
    lists:reverse(Acc);
calculate_distances_helper(Rows, Cols, Bombs, Acc) ->
    Distances = calculate_row_distances(Rows, Cols, Bombs, length(Acc) + 1, []),
    calculate_distances_helper(Rows, Cols, Bombs, [lists:reverse(Distances) | Acc]).

calculate_row_distances(_Rows, Cols, Bombs, Row, Acc) when length(Acc) == Cols ->
    Acc;
calculate_row_distances(Rows, Cols, Bombs, Row, Acc) ->
    MinDistance = calculate_min_distance(Row, length(Acc) + 1, Bombs),
    calculate_row_distances(Rows, Cols, Bombs, Row, [MinDistance | Acc]).

calculate_min_distance(Row, Col, Bombs) ->
    calculate_min_distance_helper(Row, Col, Bombs, infinity).

calculate_min_distance_helper(_Row, _Col, [], Min) ->
    Min;
calculate_min_distance_helper(Row, Col, [{BombRow, BombCol} | Rest], Min) ->
    Distance = abs(Row - BombRow) + abs(Col - BombCol),
    if
        Distance < Min ->
            calculate_min_distance_helper(Row, Col, Rest, Distance);
        true ->
            calculate_min_distance_helper(Row, Col, Rest, Min)
    end.

dijkstra(Distances, Rows, Cols) ->
    dijkstra_helper(Distances, Rows, Cols, [{1, 1, lists:nth(1, lists:nth(1, Distances))}], create_initial_visited(Rows, Cols)).

dijkstra_helper(Distances, Rows, Cols, [], Visited) ->
    Visited;
dijkstra_helper(Distances, Rows, Cols, [H | T], Visited) ->
    {Row, Col, Dist} = H,
    if
        lists:nth(Col, lists:nth(Row, Visited)) < Dist ->
            dijkstra_helper(Distances, Rows, Cols, T, Visited);
        true ->
            NewVisited = update_visited(Visited, Row, Col, Dist),
            Neighbors = get_neighbors(Rows, Cols, Row, Col),
            NewQueue = update_queue(Distances, NewVisited, Neighbors, T),
            dijkstra_helper(Distances, Rows, Cols, lists:sort(fun({_, _, D1}, {_, _, D2}) -> D1 < D2 end, NewQueue), NewVisited)
    end.

create_initial_visited(Rows, Cols) ->
    create_initial_visited_helper(Rows, Cols, []).

create_initial_visited_helper(Rows, Cols, Acc) when length(Acc) == Rows ->
    lists:reverse(Acc);
create_initial_visited_helper(Rows, Cols, Acc) ->
    create_row_visited(Rows, Cols, []),
    create_initial_visited_helper(Rows, Cols, [create_row_visited(Rows, Cols, []) | Acc]).

create_row_visited(_Rows, Cols, Acc) when length(Acc) == Cols ->
    lists:reverse(Acc);
create_row_visited(Rows, Cols, Acc) ->
    create_row_visited(Rows, Cols, [0 | Acc]).

update_visited(Visited, Row, Col, Dist) ->
    update_visited_helper(Visited, Row, Col, Dist, 1, []).

update_visited_helper(Visited, Row, Col, Dist, CurrRow, Acc) when CurrRow > length(Visited) ->
    lists:reverse(Acc);
update_visited_helper(Visited, Row, Col, Dist, CurrRow, Acc) ->
    if
        CurrRow == Row ->
            RowList = lists:nth(Row, Visited),
            NewRowList = update_row_visited(RowList, Col, Dist, 1, []),
            update_visited_helper(Visited, Row, Col, Dist, CurrRow + 1, [lists:reverse(NewRowList) | Acc]);
        true ->
            update_visited_helper(Visited, Row, Col, Dist, CurrRow + 1, [lists:nth(CurrRow, Visited) | Acc])
    end.

update_row_visited(RowList, Col, Dist, CurrCol, Acc) when CurrCol > length(RowList) ->
    Acc;
update_row_visited(RowList, Col, Dist, CurrCol, Acc) ->
    if
        CurrCol == Col ->
            update_row_visited(RowList, Col, Dist, CurrCol + 1, [Dist | Acc]);
        true ->
            update_row_visited(RowList, Col, Dist, CurrCol + 1, [lists:nth(CurrCol, RowList) | Acc])
    end.

get_neighbors(Rows, Cols, Row, Col) ->
    Neighbors = [],
    Neighbors1 = if Row > 1 then [{Row - 1, Col}] else [],
    Neighbors2 = if Row < Rows then [{Row + 1, Col}] else [],
    Neighbors3 = if Col > 1 then [{Row, Col - 1}] else [],
    Neighbors4 = if Col < Cols then [{Row, Col + 1}] else [],
    lists:flatten([Neighbors1, Neighbors2, Neighbors3, Neighbors4]).

update_queue(Distances, Visited, Neighbors, Queue) ->
    update_queue_helper(Distances, Visited, Neighbors, Queue, []).

update_queue_helper(Distances, _Visited, [], Queue, Acc) ->
    lists:append(Queue, Acc);
update_queue_helper(Distances, Visited, [{Row, Col} | Rest], Queue, Acc) ->
    Dist = lists:nth(Col, lists:nth(Row, Distances)),
    if
        lists:nth(Col, lists:nth(Row, Visited)) < Dist ->
            update_queue_helper(Distances, Visited, Rest, Queue, Acc);
        true ->
            update_queue_helper(Distances, Visited, Rest, Queue, [{Row, Col, min(Dist, lists:nth(1, lists:nth(1, Distances)))} | Acc])
    end.
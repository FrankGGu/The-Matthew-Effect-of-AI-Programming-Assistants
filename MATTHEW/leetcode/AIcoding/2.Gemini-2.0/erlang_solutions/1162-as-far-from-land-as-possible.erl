-module(as_far_from_land_as_possible).
-export([max_distance/1]).

max_distance(Grid) ->
    {Rows, Cols} = grid_size(Grid),
    Q = queue:new(),
    LandPositions = get_land_positions(Grid, Rows, Cols),

    case LandPositions of
        [] ->
            -1;
        _ when length(LandPositions) =:= Rows * Cols ->
            -1;
        _ ->
            lists:foldl(fun({Row, Col}, Acc) ->
                                 queue:in({Row, Col}, Acc)
                         end, Q, LandPositions),
            bfs(Grid, queue:size(Q), Q, 0)
    end.

grid_size(Grid) ->
    Rows = length(Grid),
    case Grid of
        [] -> {0, 0};
        [FirstRow | _] -> {Rows, length(FirstRow)}
    end.

get_land_positions(Grid, Rows, Cols) ->
    lists:flatten([
        [ {Row, Col} || Col <- lists:seq(1, Cols), lists:nth(Col, lists:nth(Row, Grid)) == 1 ]
        || Row <- lists:seq(1, Rows)
    ]).

bfs(Grid, QueueSize, Q, Distance) ->
    case queue:is_empty(Q) of
        true ->
            Distance;
        false ->
            {Value, NewQ} = queue:out(Q),
            {Row, Col} = Value,
            Neighbors = get_neighbors(Row, Col, grid_size(Grid)),
            NewQueue2 = lists:foldl(fun({NewRow, NewCol}, Acc) ->
                                             case lists:nth(NewCol, lists:nth(NewRow, Grid)) of
                                                 0 ->
                                                     update_grid(Grid, NewRow, NewCol, 1, Acc);
                                                 _ ->
                                                     Acc
                                             end
                                     end, Q, Neighbors),

            case queue:size(NewQueue2) > QueueSize of
                true ->
                    bfs(update_grid_all(Grid, NewQueue2), queue:size(NewQueue2), NewQueue2, Distance + 1);
                false ->
                    bfs(Grid, queue:size(NewQueue2), NewQueue2, Distance)
            end
    end.

get_neighbors(Row, Col, {Rows, Cols}) ->
    Neighbors = [{Row - 1, Col}, {Row + 1, Col}, {Row, Col - 1}, {Row, Col + 1}],
    lists:filter(fun({R, C}) -> R >= 1 andalso R =< Rows andalso C >= 1 andalso C =< Cols end, Neighbors).

update_grid(Grid, Row, Col, Value, Q) ->
    case lists:nth(Col, lists:nth(Row, Grid)) of
        0 ->
            queue:in({Row,Col},Q);
        _ ->
            Q
    end.

update_grid_all(Grid,Q) ->
    update_grid_all_helper(Grid, queue:to_list(Q)).

update_grid_all_helper(Grid, []) ->
    Grid;
update_grid_all_helper(Grid, [{Row, Col}|Rest]) ->
    lists:nth(Row,Grid) ! lists:setnth(Col,lists:nth(Row,Grid),2),
    update_grid_all_helper(Grid, Rest).
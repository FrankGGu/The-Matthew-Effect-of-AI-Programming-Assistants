-module(minimum_cost_to_make_at_least_one_valid_path_in_a_grid).
-export([minCost/1]).

minCost(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {_, Cost} = dijkstra(Grid, Rows, Cols),
    Cost.

dijkstra(Grid, Rows, Cols) ->
    Start = {0, 0},
    End = {Rows - 1, Cols - 1},
    Dist = maps:new(),
    Q = queue:from_list([{0, Start}]),
    dijkstra(Grid, Rows, Cols, Start, End, Dist, Q).

dijkstra(_, _, _, End, End, Dist, _) ->
    {End, maps:get(End, Dist)};
dijkstra(Grid, Rows, Cols, Current, End, Dist, Q) ->
    {Cost, Current} = queue:out(Q),
    case maps:is_key(Current, Dist) of
        true ->
            dijkstra(Grid, Rows, Cols, Current, End, Dist, Q);
        false ->
            NewDist = maps:put(Current, Cost, Dist),
            Neighbors = get_neighbors(Grid, Current, Rows, Cols),
            NewQ = lists:foldl(fun(Neighbor, Acc) ->
                NewCost = Cost + get_cost(Grid, Neighbor, Current),
                case maps:is_key(Neighbor, NewDist) of
                    true ->
                        Acc;
                    false ->
                        queue:in({NewCost, Neighbor}, Acc)
                end
            end, Q, Neighbors),
            dijkstra(Grid, Rows, Cols, Current, End, NewDist, NewQ).

get_neighbors(Grid, {R, C}, Rows, Cols) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:filter(fun({NR, NC}) ->
        NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols
    end, [ {R + DR, C + DC} || {DR, DC} <- Directions ]).

get_cost(Grid, {R, C}, {PR, PC}) ->
    Dir = case {R - PR, C - PC} of
        {-1, 0} -> up;
        {1, 0} -> down;
        {0, -1} -> left;
        {0, 1} -> right;
        _ -> error
    end,
    case Dir of
        up -> grid_value(Grid, R, C);
        down -> grid_value(Grid, R, C);
        left -> grid_value(Grid, R, C);
        right -> grid_value(Grid, R, C)
    end.

grid_value(Grid, R, C) ->
    lists:nth(R + 1, Grid),
    lists:nth(C + 1, lists:nth(R + 1, Grid)).
-module(solution).
-export([min_reorder/2]).

min_reorder(_N, Connections) ->
    Adj = build_adj_list(Connections),
    dfs(0, sets:new(), Adj).

build_adj_list(Connections) ->
    lists:foldl(
        fun([U, V], AccAdj) ->
            AccAdj1 = maps:update_with(U, fun(L) -> [{V, 1} | L] end, [{V, 1}], AccAdj),
            maps:update_with(V, fun(L) -> [{U, 0} | L] end, [{U, 0}], AccAdj1)
        end,
        maps:new(),
        Connections
    ).

dfs(City, Visited, Adj) ->
    NewVisited = sets:add_element(City, Visited),
    Neighbors = maps:get(City, Adj, []),

    lists:foldl(
        fun({Neighbor, Cost}, AccReorientations) ->
            if sets:is_element(Neighbor, NewVisited) ->
                AccReorientations;
            else
                Cost + dfs(Neighbor, NewVisited, Adj)
            end
        end,
        0,
        Neighbors
    ).
-module(rank_transform_matrix).
-export([matrix_rank_transform/1]).

matrix_rank_transform(Matrix) ->
    {M, N} = matrix_size(Matrix),
    Rows = [lists:seq(1, M) || _ <- lists:seq(1, N)],
    Cols = [lists:seq(1, N) || _ <- lists:seq(1, M)],
    Edges = build_edges(Matrix, M, N),
    Result = init_result(M, N),
    rank_transform(Matrix, Rows, Cols, Edges, Result).

rank_transform(Matrix, Rows, Cols, Edges, Result) ->
    Values = lists:usort([Matrix !! (R - 1) !! (C - 1) || R <- lists:seq(1, length(Matrix)), C <- lists:seq(1, length(Matrix !! 1))]),
    rank_transform_helper(Matrix, Rows, Cols, Edges, Result, Values, 1).

rank_transform_helper(_Matrix, _Rows, _Cols, _Edges, Result, [], _Rank) ->
    Result;
rank_transform_helper(Matrix, Rows, Cols, Edges, Result, [Value | Rest], Rank) ->
    [Components, NewEdges] = find_components(Matrix, Edges, Value),
    NewResult = update_result(Matrix, Components, Result, Rank),
    rank_transform_helper(Matrix, Rows, Cols, NewEdges, NewResult, Rest, Rank + 1).

find_components(Matrix, Edges, Value) ->
    Graph = build_graph(Edges, Value, Matrix),
    Components = find_connected_components(Graph),
    NewEdges = remove_edges(Edges, Value, Matrix),
    [Components, NewEdges].

build_graph(Edges, Value, Matrix) ->
    lists:foldl(fun({R1, C1, R2, C2}, Acc) ->
                    V1 = (R1 - 1) * length(Matrix !! 1) + C1,
                    V2 = (R2 - 1) * length(Matrix !! 1) + C2,
                    if Matrix !! (R1 - 1) !! (C1 - 1) == Value andalso
                       Matrix !! (R2 - 1) !! (C2 - 1) == Value ->
                        maps:update_with(V1, fun(L) -> lists:usort([V2 | L]) end, [V2], Acc),
                        maps:update_with(V2, fun(L) -> lists:usort([V1 | L]) end, [V1], Acc);
                       true ->
                        Acc
                    end
                end, maps:new(), Edges).

find_connected_components(Graph) ->
    find_connected_components_helper(maps:keys(Graph), [], [], Graph).

find_connected_components_helper([], Components, Visited, _Graph) ->
    [C || C <- Components, length(C) > 0];
find_connected_components_helper([V | Rest], Components, Visited, Graph) ->
    if lists:member(V, Visited) ->
        find_connected_components_helper(Rest, Components, Visited, Graph);
    true ->
        {Component, NewVisited} = dfs(V, Graph, [V]),
        find_connected_components_helper(Rest, [Component | Components], lists:usort(Visited ++ NewVisited), Graph)
    end.

dfs(V, Graph, Visited) ->
    case maps:is_key(V, Graph) of
        true ->
            Neighbors = maps:get(V, Graph),
            dfs_helper(Neighbors, Graph, lists:usort([V | Visited]), [V]);
        false ->
            {[V], [V]}
    end.

dfs_helper([], _Graph, Visited, Component) ->
    {lists:usort(Component), Visited};
dfs_helper([Neighbor | Rest], Graph, Visited, Component) ->
    if lists:member(Neighbor, Visited) ->
        dfs_helper(Rest, Graph, Visited, Component);
    true ->
        {NewComponent, NewVisited} = dfs(Neighbor, Graph, lists:usort([Neighbor | Visited])),
        dfs_helper(Rest, Graph, NewVisited, lists:usort(Component ++ NewComponent))
    end.

remove_edges(Edges, Value, Matrix) ->
    lists:filter(fun({R1, C1, R2, C2}) ->
                         not (Matrix !! (R1 - 1) !! (C1 - 1) == Value andalso
                              Matrix !! (R2 - 1) !! (C2 - 1) == Value)
                 end, Edges).

update_result(Matrix, Components, Result, Rank) ->
    lists:foldl(fun(Component, AccResult) ->
                    update_component(Matrix, Component, AccResult, Rank)
                end, Result, Components).

update_component(Matrix, Component, Result, Rank) ->
    Rows = lists:usort([((V - 1) div length(Matrix !! 1)) + 1 || V <- Component]),
    Cols = lists:usort([(rem(V - 1, length(Matrix !! 1))) + 1 || V <- Component]),
    MaxRow = lists:foldl(fun(R, Max) -> max(Max, lists:nth(R, Result !! 0)) end, 0, Rows),
    MaxCol = lists:foldl(fun(C, Max) -> max(Max, lists:nth(C, Result !! 1)) end, 0, Cols),
    NewRank = max(MaxRow, MaxCol) + 1,
    update_component_helper(Component, Result, NewRank).

update_component_helper([], Result, _Rank) ->
    Result;
update_component_helper([V | Rest], Result, Rank) ->
    R = ((V - 1) div length(Result !! 0 !! 0)) + 1,
    C = (rem(V - 1, length(Result !! 0 !! 0))) + 1,
    NewResult = update_rank(Result, R, C, Rank),
    update_component_helper(Rest, NewResult, Rank).

update_rank(Result, R, C, Rank) ->
    {Rows, Cols, MatrixRanks} = {Result !! 0, Result !! 1, Result !! 2},
    NewRows = lists:nth(R, Rows) orelse 0,
    NewCols = lists:nth(C, Cols) orelse 0,
    MaxRank = max(NewRows, NewCols, Rank),
    NewRowsList = lists:nth(R, Rows) -> MaxRank; MaxRank,
    NewColsList = lists:nth(C, Cols) -> MaxRank; MaxRank,
    NewMatrixRanks = set_matrix_value(MatrixRanks, R, C, MaxRank),
    {replace(Result, 0, replace(Rows, R, MaxRank)),
     replace(Result, 1, replace(Cols, C, MaxRank)),
     replace(Result, 2, NewMatrixRanks)}.

set_matrix_value(Matrix, R, C, Value) ->
    replace(Matrix, R - 1, replace(lists:nth(R, Matrix), C - 1, Value)).

replace(List, Index, NewValue) ->
    lists:map(fun({E, I}) -> if I == Index + 1 then NewValue else E end end, lists:zip(List, lists:seq(1, length(List)))).

build_edges(Matrix, M, N) ->
    Rows = [{R, C1, R, C2} || R <- lists:seq(1, M), C1 <- lists:seq(1, N), C2 <- lists:seq(C1 + 1, N)],
    Cols = [{R1, C, R2, C} || C <- lists:seq(1, N), R1 <- lists:seq(1, M), R2 <- lists:seq(R1 + 1, M)],
    Rows ++ Cols.

init_result(M, N) ->
    Rows = lists:duplicate(M, 0),
    Cols = lists:duplicate(N, 0),
    MatrixRanks = [[0 || _ <- lists:seq(1, N)] || _ <- lists:seq(1, M)],
    {Rows, Cols, MatrixRanks}.

matrix_size(Matrix) ->
    {length(Matrix), length(hd(Matrix))}.
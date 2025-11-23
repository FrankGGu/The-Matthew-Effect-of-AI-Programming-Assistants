-module(solution).
-export([shortest_distance_after_road_addition_queries_i/2]).

-include_lib("kernel/include/array.hrl").

infinity() -> 1000000000. % A sufficiently large number

create_initial_dist_matrix_array(N) ->
    % Create N+1 x N+1 array, ignoring index 0 for 1-indexed node access.
    % Initialize outer array (rows).
    InitialMatrix = array:new([{size, N + 1}, {fixed, true}]),

    lists:foldl(fun(I, AccMatrix) ->
        % For each row I, create an inner array (columns).
        Row = array:new([{size, N + 1}, {fixed, true}]),
        UpdatedRow = lists:foldl(fun(J, AccRow) ->
            Val = case {I, J} of {X, X} -> 0; _ -> infinity() end,
            array:set(J, Val, AccRow)
        end, Row, lists:seq(1, N)), % Iterate 1 to N for columns
        array:set(I, UpdatedRow, AccMatrix)
    end, InitialMatrix, lists:seq(1, N)). % Iterate 1 to N for rows

update_matrix_element_array(Matrix, R, C, Val) ->
    Row = array:get(R, Matrix),
    UpdatedRow = array:set(C, Val, Row),
    array:set(R, UpdatedRow, Matrix).

update_dist_matrix_with_new_edge_array(DistMatrix, N, U, V) ->
    % Apply Floyd-Warshall step for U as an intermediate node.
    IntermediateMatrix1 = lists:foldl(fun(I, AccMatrix) ->
        RowI_Acc = array:get(I, AccMatrix),
        DistIU = array:get(U, RowI_Acc),
        lists:foldl(fun(J, InnerAccMatrix) ->
            RowI_Inner = array:get(I, InnerAccMatrix),
            DistIJ = array:get(J, RowI_Inner),
            RowU_Inner = array:get(U, InnerAccMatrix),
            DistUJ = array:get(J, RowU_Inner),
            NewDistIJ = min(DistIJ, DistIU + DistUJ),
            update_matrix_element_array(InnerAccMatrix, I, J, NewDistIJ)
        end, AccMatrix, lists:seq(1, N))
    end, DistMatrix, lists:seq(1, N)),

    % Apply Floyd-Warshall step for V as an intermediate node.
    IntermediateMatrix2 = lists:foldl(fun(I, AccMatrix) ->
        RowI_Acc = array:get(I, AccMatrix),
        DistIV = array:get(V, RowI_Acc),
        lists:foldl(fun(J, InnerAccMatrix) ->
            RowI_Inner = array:get(I, InnerAccMatrix),
            DistIJ = array:get(J, RowI_Inner),
            RowV_Inner = array:get(V, InnerAccMatrix),
            DistVJ = array:get(J, RowV_Inner),
            NewDistIJ = min(DistIJ, DistIV + DistVJ),
            update_matrix_element_array(InnerAccMatrix, I, J, NewDistIJ)
        end, AccMatrix, lists:seq(1, N))
    end, IntermediateMatrix1, lists:seq(1, N)),

    IntermediateMatrix2.

shortest_distance_after_road_addition_queries_i(N, Queries) ->
    InitialDistMatrix = create_initial_dist_matrix_array(N),
    {_, AnswersReversed} = lists:foldl(fun(Query, {AccDistMatrix, AccAnswers}) ->
        {U, V, W, S, T} = Query,

        % Update direct edge (U, V) and (V, U) with the new weight W.
        % We take the minimum of the current direct path and the new edge weight.
        DistUV_current = array:get(V, array:get(U, AccDistMatrix)),
        DistVU_current = array:get(U, array:get(V, AccDistMatrix)),

        TempDistMatrix1 = update_matrix_element_array(AccDistMatrix, U, V, min(DistUV_current, W)),
        TempDistMatrix2 = update_matrix_element_array(TempDistMatrix1, V, U, min(DistVU_current, W)),

        % Apply Floyd-Warshall update for the new edge (U, V).
        % This step ensures all-pairs shortest paths are updated considering U and V as intermediate nodes.
        UpdatedDistMatrix = update_dist_matrix_with_new_edge_array(TempDistMatrix2, N, U, V),

        % Query shortest distance between S and T.
        ShortestDist = array:get(T, array:get(S, UpdatedDistMatrix)),

        % Accumulate answers in reverse order for efficient list construction.
        {UpdatedDistMatrix, [ShortestDist | AccAnswers]}
    end, {InitialDistMatrix, []}, Queries),

    % Reverse the accumulated answers to get them in the correct order.
    lists:reverse(AnswersReversed).
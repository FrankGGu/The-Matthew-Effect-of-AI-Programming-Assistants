-module(solution).
-export([numberOfPossibleSets/3]).

-define(INFINITY, 1_000_000_000). % A large enough number for unreachable paths

numberOfPossibleSets(N, MaxDistance, Roads) ->
    % Initialize adjacency matrix with direct road weights
    Adj = initialize_adj_matrix(N, Roads),

    % Iterate through all possible subsets of branches.
    % A mask represents the set of open branches (i-th bit set means branch i is open).
    MaxMask = (1 bsl N) - 1,
    lists:foldl(fun(Mask, Acc) ->
        OpenBranches = get_open_branches(N, Mask),
        case is_valid_set(OpenBranches, Adj, MaxDistance) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, lists:seq(0, MaxMask)).

initialize_adj_matrix(N, Roads) ->
    % Create an N x N matrix, filled with infinity, 0 on diagonal
    Matrix = lists:duplicate(N, lists:duplicate(N, ?INFINITY)),
    MatrixWithDiagonals = set_diagonals_to_zero(Matrix, N, 0),

    % Populate with road weights, adjusting to 0-indexed
    lists:foldl(fun([U, V, W], CurrentMatrix) ->
        U0 = U - 1,
        V0 = V - 1,
        % Update both (U0, V0) and (V0, U0) with the minimum weight
        UpdatedMatrix1 = update_matrix_cell(CurrentMatrix, U0, V0, W),
        update_matrix_cell(UpdatedMatrix1, V0, U0, W)
    end, MatrixWithDiagonals, Roads).

set_diagonals_to_zero(Matrix, N, I) when I < N ->
    % Erlang lists are 1-indexed, so add 1 to I
    Row = lists:nth(I + 1, Matrix),
    UpdatedRow = lists:replace_nth(I + 1, 0, Row),
    NewMatrix = lists:replace_nth(I + 1, UpdatedRow, Matrix),
    set_diagonals_to_zero(NewMatrix, N, I + 1);
set_diagonals_to_zero(Matrix, _N, _I) ->
    Matrix.

update_matrix_cell(Matrix, RowIdx, ColIdx, NewVal) ->
    % Get the row (1-indexed)
    Row = lists:nth(RowIdx + 1, Matrix),
    % Get current value (1-indexed)
    CurrentVal = lists:nth(ColIdx + 1, Row),
    % Update if NewVal is smaller
    ValToSet = min(CurrentVal, NewVal),
    % Update the row (1-indexed)
    UpdatedRow = lists:replace_nth(ColIdx + 1, ValToSet, Row),
    % Update the matrix with the new row (1-indexed)
    lists:replace_nth(RowIdx + 1, UpdatedRow, Matrix).

get_matrix_cell(Matrix, RowIdx, ColIdx) ->
    % Get value from matrix (0-indexed inputs, 1-indexed for lists:nth)
    lists:nth(ColIdx + 1, lists:nth(RowIdx + 1, Matrix)).

get_open_branches(N, Mask) ->
    lists:filtermap(fun(I) ->
        if ((Mask bsr I) band 1) == 1 -> {true, I}; % If I-th bit is set, branch I is open
           true -> false
        end
    end, lists:seq(0, N - 1)).

is_valid_set(OpenBranches, Adj, MaxDistance) ->
    NumOpen = length(OpenBranches),

    % If 0 or 1 branches are open, the maximum distance is 0, which is always <= MaxDistance
    if NumOpen =< 1 -> true;
       true ->
            % Create a distance matrix for only the open branches
            % Initialize with infinity, 0 on diagonal
            SubGraphDist = lists:duplicate(NumOpen, lists:duplicate(NumOpen, ?INFINITY)),
            SubGraphDistWithDiagonals = set_diagonals_to_zero(SubGraphDist, NumOpen, 0),

            % Map original branch indices to 0..NumOpen-1 indices for the subgraph matrix
            OriginalToSubIndex = maps:from_list(lists:zip(OpenBranches, lists:seq(0, NumOpen - 1))),

            % Populate SubGraphDist using Adj for direct connections between open branches
            PopulatedSubGraphDist = lists:foldl(fun(I_orig, CurrentSubDist) ->
                lists:foldl(fun(J_orig, InnerCurrentSubDist) ->
                    % Get subgraph indices
                    I_sub = maps:get(I_orig, OriginalToSubIndex),
                    J_sub = maps:get(J_orig, OriginalToSubIndex),
                    % Get original distance
                    Dist = get_matrix_cell(Adj, I_orig, J_orig),
                    % Update subgraph distance
                    update_matrix_cell(InnerCurrentSubDist, I_sub, J_sub, Dist)
                end, CurrentSubDist, OpenBranches)
            end, SubGraphDistWithDiagonals, OpenBranches),

            % Run Floyd-Warshall on the subgraph distance matrix
            FloydWarshallDist = run_floyd_warshall(PopulatedSubGraphDist, NumOpen),

            % Find the maximum distance among all pairs in the resulting matrix
            MaxPathDistance = find_max_distance(FloydWarshallDist, NumOpen),

            MaxPathDistance =< MaxDistance
    end.

run_floyd_warshall(DistMatrix, N) ->
    lists:foldl(fun(K, CurrentDist) -> % Intermediate node
        lists:foldl(fun(I, InnerCurrentDist) -> % Source node
            lists:foldl(fun(J, InnermostCurrentDist) -> % Destination node
                DIJ = get_matrix_cell(InnermostCurrentDist, I, J),
                DIK = get_matrix_cell(InnermostCurrentDist, I, K),
                DKJ = get_matrix_cell(InnermostCurrentDist, K, J),

                % Check for overflow and infinity to prevent incorrect sums
                NewVal = if DIK == ?INFINITY or DKJ == ?INFINITY -> ?INFINITY;
                           true -> DIK + DKJ
                        end,

                if NewVal < DIJ ->
                    update_matrix_cell(InnermostCurrentDist, I, J, NewVal);
                   true -> InnermostCurrentDist
                end
            end, InnerCurrentDist, lists:seq(0, N - 1))
        end, CurrentDist, lists:seq(0, N - 1))
    end, DistMatrix, lists:seq(0, N - 1)).

find_max_distance(DistMatrix, N) ->
    Max = lists:foldl(fun(Row, CurrentMax) ->
        lists:foldl(fun(Val, InnerCurrentMax) ->
            if Val == ?INFINITY -> ?INFINITY; % If any pair is unreachable, the max distance is effectively infinity
               true -> max(InnerCurrentMax, Val)
            end
        end, CurrentMax, Row)
    end, 0, DistMatrix),
    Max.
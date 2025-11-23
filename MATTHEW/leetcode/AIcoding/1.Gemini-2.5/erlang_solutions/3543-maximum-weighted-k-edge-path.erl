-module(solution).
-export([solve/3]).

-define(NEG_INF, -1_000_000_000_000_000_000_000). % -10^21

solve(N, K, Edges) ->
    % Create the initial adjacency matrix representing 1-edge paths.
    % Matrix[i][j] stores the maximum weight of a direct edge from i to j.
    InitialMatrix = create_initial_matrix(N, Edges),

    % Compute the matrix power M^K using (max, +) algebra.
    % The resulting matrix ResultMatrix[i][j] will contain the maximum weight
    % of a path of exactly K edges from node i to node j.
    ResultMatrix = matrix_power(InitialMatrix, K, N),

    % Find the maximum value in the ResultMatrix. This represents the maximum
    % weight of any K-edge path between any two nodes in the graph.
    MaxWeight = lists:foldl(fun(Row, Acc) ->
                                lists:foldl(fun(Val, RowAcc) ->
                                                max(Val, RowAcc)
                                            end, Acc, Row)
                            end, ?NEG_INF, ResultMatrix),

    MaxWeight.

create_initial_matrix(N, Edges) ->
    % Initialize matrix with NEG_INF.
    Matrix = lists:duplicate(N, lists:duplicate(N, ?NEG_INF)),

    % Fill in edge weights. Adjust U and V to be 0-indexed for list operations.
    lists:foldl(fun({U, V, W}, AccMatrix) ->
                    % Get the row for node U (U-1 index).
                    RowU = lists:nth(U, AccMatrix),
                    % Update the element at V-1 index in RowU with weight W.
                    UpdatedRowU = lists:replace_at(V-1, W, RowU),
                    % Replace the original RowU in AccMatrix with UpdatedRowU.
                    lists:replace_at(U-1, UpdatedRowU, AccMatrix)
                end, Matrix, Edges).

matrix_multiply(MatrixA, MatrixB, N) ->
    [ [ lists:foldl(fun(K_idx, MaxVal) ->
                         % MatrixA[I_idx][K_idx] + MatrixB[K_idx][J_idx]
                         Val = lists:nth(I_idx+1, lists:nth(K_idx+1, MatrixA)) +
                               lists:nth(K_idx+1, lists:nth(J_idx+1, MatrixB)),
                         max(MaxVal, Val)
                     end, ?NEG_INF, lists:seq(0, N-1)) % Iterate over K_idx (0 to N-1)
        || J_idx <- lists:seq(0, N-1) ] % Iterate over J_idx (0 to N-1)
      || I_idx <- lists:seq(0, N-1) ]. % Iterate over I_idx (0 to N-1)

matrix_power(Matrix, K, N) ->
    % The identity matrix for (max, +) algebra has 0 on the diagonal
    % and NEG_INF elsewhere.
    IdentityMatrix = lists:foldl(fun(I_idx, AccMatrix) ->
                                     lists:replace_at(I_idx,
                                                      lists:replace_at(I_idx, 0, lists:nth(I_idx+1, AccMatrix)),
                                                      AccMatrix)
                                 end, lists:duplicate(N, lists:duplicate(N, ?NEG_INF)), lists:seq(0, N-1)),

    matrix_power_recursive(Matrix, K, N, IdentityMatrix).

matrix_power_recursive(_, 0, _, ResultAcc) -> ResultAcc; % Base case: K=0, return accumulated result
matrix_power_recursive(Matrix, K, N, ResultAcc) ->
    if
        K rem 2 == 1 -> % If K is odd
            % Multiply current result by Matrix, and square Matrix
            NewResultAcc = matrix_multiply(ResultAcc, Matrix, N),
            NewMatrix = matrix_multiply(Matrix, Matrix, N),
            matrix_power_recursive(NewMatrix, (K-1) div 2, N, NewResultAcc);
        true -> % If K is even
            % Just square Matrix
            NewMatrix = matrix_multiply(Matrix, Matrix, N),
            matrix_power_recursive(NewMatrix, K div 2, N, ResultAcc)
    end.
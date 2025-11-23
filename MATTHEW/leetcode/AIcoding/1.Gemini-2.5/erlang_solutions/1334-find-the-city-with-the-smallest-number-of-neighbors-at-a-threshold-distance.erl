-module(solution).
-export([findTheCity/3]).

findTheCity(N, Edges, Threshold) ->
    Infinity = N * 10001, % A value larger than any possible path sum (N * max_weight)

    % Initialize distance matrix as an array of arrays
    % DistMatrix[I] will be an array representing the I-th row
    % All distances are Infinity initially, except Dist[i][i] = 0
    DistMatrix0 = array:new([{size, N}, {fixed, true}]),
    DistMatrix1 = array:foldl(
        fun(I, _, AccMatrix) ->
            Row = array:new([{size, N}, {fixed, true}]),
            Row1 = array:foldl(
                fun(J, _, R) when I == J -> array:set(J, 0, R); % Distance from a city to itself is 0
                   (J, _, R) -> array:set(J, Infinity, R) % No direct path initially
                end, Row, 0, N - 1),
            array:set(I, Row1, AccMatrix)
        end, DistMatrix0, 0, N - 1),

    % Populate initial distances from given edges
    InitialDistMatrix = lists:foldl(
        fun([U, V, W], AccMatrix) ->
            % Edges are bidirectional
            RowU = array:get(U, AccMatrix),
            RowV = array:get(V, AccMatrix),

            UpdatedRowU = array:set(V, W, RowU),
            UpdatedRowV = array:set(U, W, RowV),

            AccMatrix1 = array:set(U, UpdatedRowU, AccMatrix),
            array:set(V, UpdatedRowV, AccMatrix1)
        end, DistMatrix1, Edges),

    % Floyd-Warshall algorithm to find all-pairs shortest paths
    FinalDistMatrix = lists:foldl(
        fun(K, AccMatrix) -> % K is the intermediate city
            lists:foldl(
                fun(I, AccMatrixI) -> % I is the source city
                    lists:foldl(
                        fun(J, AccMatrixJ) -> % J is the destination city
                            % Get current distances from the matrix state
                            RowI_current = array:get(I, AccMatrixJ),
                            RowK_current = array:get(K, AccMatrixJ),

                            DistIK = array:get(K, RowI_current),
                            DistKJ = array:get(J, RowK_current),
                            DistIJ = array:get(J, RowI_current),

                            IfPathExists = DistIK + DistKJ,

                            NewDistIJ = erlang:min(DistIJ, IfPathExists),

                            % Update matrix if a shorter path is found
                            if NewDistIJ < DistIJ ->
                                UpdatedRowI = array:set(J, NewDistIJ, RowI_current),
                                array:set(I, UpdatedRowI, AccMatrixJ);
                            true ->
                                AccMatrixJ
                            end
                        end, AccMatrixI, 0, N - 1)
                end, AccMatrix, 0, N - 1)
        end, InitialDistMatrix, 0, N - 1),

    % Find the city with the smallest number of reachable neighbors
    % and largest index in case of a tie
    {MinNeighborsCount, ResultCity} = lists:foldl(
        fun(I, {CurrentMinCount, CurrentResultCity}) ->
            RowI = array:get(I, FinalDistMatrix), % Get the row for the current city I
            NeighborsCount = lists:foldl(
                fun(J, AccCount) when I == J -> AccCount; % Don't count self
                   (J, AccCount) ->
                        DistIJ = array:get(J, RowI),
                        if DistIJ =< Threshold -> AccCount + 1; % Neighbor if distance <= threshold
                           true -> AccCount
                        end
                end, 0, 0, N - 1),

            % Update if current city has fewer neighbors, or same number but larger index
            if NeighborsCount =< CurrentMinCount ->
                {NeighborsCount, I};
            true ->
                {CurrentMinCount, CurrentResultCity}
            end
        end, {N + 1, -1}, 0, N - 1), % Initial min count is N+1 (more than any city can have), initial city is -1

    ResultCity.
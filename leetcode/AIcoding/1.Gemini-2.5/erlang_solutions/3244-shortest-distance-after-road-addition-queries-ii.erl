-module(solution).
-export([solve/4]).

-include_lib("kernel/include/array.hrl").

-define(INF, 1_000_000_000). % A large number representing infinity for path distances

init_dist(N) ->
    Rows = lists:map(fun(I) ->
        RowList = lists:map(fun(J) ->
            if I == J -> 0; true -> ?INF end
        end, lists:seq(1, N)),
        array:from_list(RowList)
    end, lists:seq(1, N)),
    array:from_list(Rows).

get_dist(Matrix, RowIdx, ColIdx) ->
    Row = array:get(RowIdx - 1, Matrix),
    array:get(ColIdx - 1, Row).

set_dist(Matrix, RowIdx, ColIdx, NewVal) ->
    Row = array:get(RowIdx - 1, Matrix),
    NewRow = array:set(ColIdx - 1, NewVal, Row),
    array:set(RowIdx - 1, NewRow, Matrix).

solve(N, InitialEdges, RoadAdditions, Queries) ->
    % 1. Initialize distance matrix
    Dist = init_dist(N),

    % 2. Apply initial edges to the distance matrix
    DistWithInitial = lists:foldl(fun([U, V, W], CurrentDist) ->
        MinUV = min(get_dist(CurrentDist, U, V), W),
        MinVU = min(get_dist(CurrentDist, V, U), W), % For undirected graph
        TmpDist1 = set_dist(CurrentDist, U, V, MinUV),
        set_dist(TmpDist1, V, U, MinVU)
    end, Dist, InitialEdges),

    % 3. Run initial Floyd-Warshall to get all-pairs shortest paths for the initial graph
    InitialAPSP = floyd_warshall(DistWithInitial, N),

    % 4. Group queries by the number of roads added (K)
    % This allows processing all queries for a specific K at once.
    GroupedQueries = lists:foldl(fun([S, T, K], Acc) ->
        maps:update_with(K, fun(List) -> [{S, T} | List] end, [{S, T}], Acc)
    end, #{}, Queries),

    % 5. Handle queries for K=0 (before any road additions)
    InitialResults = case maps:find(0, GroupedQueries) of
        {ok, QList} ->
            lists:foldl(fun({S, T}, RAcc) ->
                Path = get_dist(InitialAPSP, S, T),
                maps:put({S, T, 0}, Path, RAcc)
            end, #{}, QList);
        error ->
            #{}
    end,

    % 6. Iterate through road additions, update APSP, and process queries for each K
    % The K_idx is 1-indexed, representing the number of roads added so far.
    {_FinalDistMatrix, FinalResults} = lists:foldl(fun({K_idx, [U, V, W]}, {DistAcc, ResultsAcc}) ->
        % Update the distance matrix with the new edge (U, V, W)
        % This is the O(N^2) update step for Floyd-Warshall.
        NewDistAcc = update_dist_with_edge_optimized(DistAcc, U, V, W),

        % Process queries that are due after K_idx roads have been added
        case maps:find(K_idx, GroupedQueries) of
            {ok, QList} ->
                NewResultsAcc = lists:foldl(fun({S, T}, RAcc) ->
                    Path = get_dist(NewDistAcc, S, T),
                    maps:put({S, T, K_idx}, Path, RAcc)
                end, ResultsAcc, QList);
            error ->
                ResultsAcc
        end,
        {NewDistAcc, NewResultsAcc}
    end, {InitialAPSP, InitialResults}, lists:zip(lists:seq(1, length(RoadAdditions)), RoadAdditions)),

    % 7. Format results for output.
    % Iterate through the original Queries list to ensure the output order is correct.
    lists:map(fun([S, T, K]) ->
        Path = maps:get({S, T, K}, FinalResults),
        if Path == ?INF -> -1; true -> Path end % Return -1 for unreachable paths
    end, Queries).

update_dist_with_edge_optimized(Dist, U, V, W) ->
    N = array:size(Dist), % Get N from the array size

    % Update the direct edge (U, V) and (V, U) with the new weight if it's shorter.
    CurrentUV = get_dist(Dist, U, V),
    CurrentVU = get_dist(Dist, V, U),

    MinUV = min(CurrentUV, W),
    MinVU = min(CurrentVU, W), % For undirected graph

    TmpDist1 = set_dist(Dist, U, V, MinUV),
    TmpDist2 = set_dist(TmpDist1, V, U, MinVU),

    % Apply the Floyd-Warshall update for all pairs (i, j).
    % A new shortest path from i to j might now pass through the new edge (U, V) or (V, U).
    lists:foldl(fun(I, CurrentDist) ->
        lists:foldl(fun(J, InnerCurrentDist) ->
            D_IJ = get_dist(InnerCurrentDist, I, J),

            % Path via I -> ... -> U -> V -> ... -> J
            D_IU = get_dist(InnerCurrentDist, I, U),
            D_VJ = get_dist(InnerCurrentDist, V, J),
            PathViaUV = if D_IU == ?INF orelse D_VJ == ?INF -> ?INF; true -> D_IU + MinUV + D_VJ end,

            % Path via I -> ... -> V -> U -> ... -> J (for undirected graph)
            D_IV = get_dist(InnerCurrentDist, I, V),
            D_UJ = get_dist(InnerCurrentDist, U, J),
            PathViaVU = if D_IV == ?INF orelse D_UJ == ?INF -> ?INF; true -> D_IV + MinVU + D_UJ end,

            NewD_IJ = min(D_IJ, min(PathViaUV, PathViaVU)),
            set_dist(InnerCurrentDist, I, J, NewD_IJ)
        end, CurrentDist, lists:seq(1, N))
    end, TmpDist2, lists:seq(1, N)).

floyd_warshall(DistMatrix, N) ->
    lists:foldl(fun(K, CurrentDist) -> % K is the intermediate node
        lists:foldl(fun(I, InnerDist) -> % I is the source node
            lists:foldl(fun(J, DeepDist) -> % J is the destination node
                D_IK = get_dist(DeepDist, I, K),
                D_KJ = get_dist(DeepDist, K, J),

                PathViaK = if D_IK == ?INF orelse D_KJ == ?INF -> ?INF; true -> D_IK + D_KJ end,

                CurrentD_IJ = get_dist(DeepDist, I, J),

                NewD_IJ = min(CurrentD_IJ, PathViaK),
                set_dist(DeepDist, I, J, NewD_IJ)
            end, InnerDist, lists:seq(1, N))
        end, CurrentDist, lists:seq(1, N))
    end, DistMatrix, lists:seq(1, N)).
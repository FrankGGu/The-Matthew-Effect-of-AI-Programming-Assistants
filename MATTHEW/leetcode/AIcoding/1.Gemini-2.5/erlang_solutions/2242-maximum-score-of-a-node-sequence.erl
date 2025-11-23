-module(solution).
-export([maximum_score/3]).

maximum_score(N, Edges, Scores) ->
    ScoresArr = array:from_list(Scores),

    % Initialize adjacency list for each node
    % Adj[NodeIdx] = [NeighborIdx, ...]
    Adj = array:new([{size, N}, {default, []}]),

    % Build initial adjacency list
    Adj1 = lists:foldl(
        fun([U, V], AccAdj) ->
            AccAdj1 = array:set(U, [V | array:get(U, AccAdj)], AccAdj),
            array:set(V, [U | array:get(V, AccAdj1)], AccAdj1)
        end,
        Adj,
        Edges
    ),

    % Process adjacency list to keep only top 3 neighbors by score
    % AdjTopK[NodeIdx] = [{Score_Neighbor, NeighborIdx}, ...]
    AdjTopK = array:from_list(
        [
            begin
                Neighbors = array:get(NodeIdx, Adj1),
                SortedNeighbors = lists:sort(
                    fun({_S1, N1}, {_S2, N2}) ->
                        array:get(N1, ScoresArr) >= array:get(N2, ScoresArr)
                    end,
                    [{array:get(N, ScoresArr), N} || N <- Neighbors]
                ),
                lists:sublist(SortedNeighbors, 3) % Keep top 3 neighbors
            end
            || NodeIdx <- lists:seq(0, N-1)
        ]
    ),

    MaxScore = lists:foldl(
        fun([U, V], CurrentMaxScore) ->
            ScoreU = array:get(U, ScoresArr),
            ScoreV = array:get(V, ScoresArr),

            NeighborsU = array:get(U, AdjTopK),
            NeighborsV = array:get(V, AdjTopK),

            lists:foldl(
                fun({ScoreA, A}, InnerMaxScore1) ->
                    % Node A must not be V
                    if A == V ->
                           InnerMaxScore1;
                       true ->
                           lists:foldl(
                               fun({ScoreD, D}, InnerMaxScore2) ->
                                   % Node D must not be U and not be A
                                   if D == U; D == A ->
                                          InnerMaxScore2;
                                      true ->
                                          CurrentPathScore = ScoreU + ScoreV + ScoreA + ScoreD - 3,
                                          max(InnerMaxScore2, CurrentPathScore)
                                   end
                               end,
                               InnerMaxScore1,
                               NeighborsV
                           )
                    end
                end,
                CurrentMaxScore,
                NeighborsU
            )
        end,
        -1, % Initial max_score (as per problem, if no path exists, return -1)
        Edges
    ),

    MaxScore.
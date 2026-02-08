-module(solution).
-export([longest_special_path_ii/2]).

topological_sort_and_dp(N, Adj, InDegree, DP, Queue) ->
    if queue:is_empty(Queue) ->
        {DP, InDegree};
    else
        {Node, NewQueue} = queue:out(Queue),

        Neighbors = array:get(Node, Adj),

        {UpdatedDP, UpdatedInDegree, NextQueue} = lists:foldl(
            fun({Neighbor, Weight}, {AccDP, AccInDegree, AccQ}) ->
                CurrentPathToNode = array:get(Node, AccDP),

                if CurrentPathToNode == -1000000000 ->
                    {AccDP, AccInDegree, AccQ};
                else
                    CurrentPathToNeighbor = array:get(Neighbor, AccDP),
                    NewPathToNeighbor = CurrentPathToNode + Weight,

                    NewAccDP = array:set(Neighbor, max(CurrentPathToNeighbor, NewPathToNeighbor), AccDP),

                    NeighborInDegree = array:get(Neighbor, AccInDegree),
                    NewNeighborInDegree = NeighborInDegree - 1,
                    NewAccInDegree = array:set(Neighbor, NewNeighborInDegree, AccInDegree),

                    NewAccQ = if NewNeighborInDegree == 0 ->
                                    queue:in(Neighbor, AccQ);
                               else
                                    AccQ
                               end,
                    {NewAccDP, NewAccInDegree, NewAccQ}
                end
            end,
            {DP, InDegree, NewQueue},
            Neighbors
        ),
        topological_sort_and_dp(N, Adj, UpdatedInDegree, UpdatedDP, NextQueue)
    end.

longest_special_path_ii(N, Edges) ->
    InitialAdj = array:new([{size, N}, {fixed, true}, {default, []}]),
    InitialInDegree = array:new([{size, N}, {fixed, true}, {default, 0}]),

    {FinalAdj, FinalInDegree} = lists:foldl(
        fun([U, V, W], {AccAdj, AccInDegree}) ->
            Adj_U = array:get(U, AccAdj),
            NewAccAdj = array:set(U, [{V, W} | Adj_U], AccAdj),
            InDegree_V = array:get(V, AccInDegree),
            NewAccInDegree = array:set(V, InDegree_V + 1, AccInDegree),
            {NewAccAdj, NewAccInDegree}
        end,
        {InitialAdj, InitialInDegree},
        Edges
    ),

    InitialDP = array:new([{size, N}, {fixed, true}, {default, -1000000000}]),

    {DP_with_sources, Queue_with_sources} = lists:foldl(fun(Node, {AccDP, AccQ}) ->
        case array:get(Node, FinalInDegree) of
            0 ->
                NewAccDP = array:set(Node, 0, AccDP),
                NewAccQ = queue:in(Node, AccQ),
                {NewAccDP, NewAccQ};
            _ ->
                {AccDP, AccQ}
        end
    end, {InitialDP, queue:new()}, lists:seq(0, N-1)),

    {FinalDP, _} = topological_sort_and_dp(N, FinalAdj, FinalInDegree, DP_with_sources, Queue_with_sources),

    MaxPath = lists:foldl(fun(I, Max) ->
        PathLen = array:get(I, FinalDP),
        max(Max, PathLen)
    end, -1000000000, lists:seq(0, N-1)),

    max(0, MaxPath).
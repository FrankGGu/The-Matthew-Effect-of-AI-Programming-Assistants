-module(solution).
-export([max_star_sum/3]).

max_star_sum(Nodes, Edges, K) ->
    N = length(Nodes),

    NodesArray = array:from_list(Nodes),

    AdjArray = build_adj_array(N, Edges),

    InitialMaxSum = lists:max(Nodes),

    lists:foldl(fun(CenterIdx, CurrentMaxSum) ->
        CenterValue = array:get(CenterIdx, NodesArray),

        Neighbors = array:get(CenterIdx, AdjArray),

        NeighborValues = [array:get(NbrIdx, NodesArray) || NbrIdx <- Neighbors],

        PositiveNeighborValues = lists:filter(fun(Val) -> Val > 0 end, NeighborValues),
        SortedPositiveNeighborValues = lists:reverse(lists:sort(PositiveNeighborValues)),

        NumToTake = min(K, length(SortedPositiveNeighborValues)),
        SelectedNeighborValues = lists:sublist(SortedPositiveNeighborValues, NumToTake),

        CurrentStarSum = CenterValue + lists:foldl(fun(Val, Acc) -> Acc + Val end, 0, SelectedNeighborValues),

        max(CurrentMaxSum, CurrentStarSum)
    end, InitialMaxSum, lists:seq(0, N - 1)).

build_adj_array(N, Edges) ->
    AdjArray = array:new([{size, N}, {fixed, true}, {default, []}]),

    lists:foldl(fun([U, V], AccAdjArray) ->
        UNeighbors = array:get(U, AccAdjArray),
        VNeighbors = array:get(V, AccAdjArray),

        AccAdjArray1 = array:set(U, [V | UNeighbors], AccAdjArray),
        array:set(V, [U | VNeighbors], AccAdjArray1)
    end, AdjArray, Edges).
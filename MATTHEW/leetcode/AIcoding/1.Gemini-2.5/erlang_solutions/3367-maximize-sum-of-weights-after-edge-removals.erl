-module(solution).
-export([solve/3]).

build_adj_list(N, Edges) ->
    Adj = array:new([{size, N}, {fixed, true}, {default, []}]),
    lists:foldl(
        fun({U, V}, CurrentAdj) ->
            Adj1 = array:set(U, [V | array:get(U, CurrentAdj)], CurrentAdj),
            array:set(V, [U | array:get(V, Adj1)], Adj1)
        end,
        Adj,
        Edges
    ).

dfs_with_acc(Node, Parent, Adj, WeightsArray, TotalSum, AccMaxProduct) ->
    NodeWeight = array:get(Node, WeightsArray),

    {SubtreeSumChildren, FinalAccMaxProduct} = lists:foldl(
        fun(Neighbor, {CurrentSubtreeSumChildren, CurrentMaxProduct}) ->
            if Neighbor == Parent ->
                {CurrentSubtreeSumChildren, CurrentMaxProduct};
            true ->
                {ChildSubtreeSum, NewMaxProductFromChild} = 
                    dfs_with_acc(Neighbor, Node, Adj, WeightsArray, TotalSum, CurrentMaxProduct),

                ProductForThisEdge = ChildSubtreeSum * (TotalSum - ChildSubtreeSum),

                {CurrentSubtreeSumChildren + ChildSubtreeSum, max(NewMaxProductFromChild, ProductForThisEdge)}
            end
        end,
        {0, AccMaxProduct},
        array:get(Node, Adj)
    ),

    SubtreeSumForNode = NodeWeight + SubtreeSumChildren,

    {SubtreeSumForNode, FinalAccMaxProduct}.

solve(N, Edges, Weights) ->
    Adj = build_adj_list(N, Edges),
    WeightsArray = array:from_list(Weights),
    TotalSum = lists:sum(Weights),

    {_RootSubtreeSum, MaxProduct} = dfs_with_acc(0, -1, Adj, WeightsArray, TotalSum, 0),
    MaxProduct.
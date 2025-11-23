-record(node, {val, neighbors}).

cloneGraph(Node) ->
    case Node of
        nil -> nil;
        #node{} ->
            {ClonedNode, _FinalMap} = clone_graph_aux(Node, #{}),
            ClonedNode
    end.

clone_graph_aux(nil, AccMap) ->
    {nil, AccMap};
clone_graph_aux(Node, AccMap) ->
    case maps:find(Node.val, AccMap) of
        {ok, ClonedNode} ->
            {ClonedNode, AccMap};
        _ ->
            % Create a temporary node with empty neighbors.
            TempClonedNode = #node{val = Node.val, neighbors = []},

            % Put this temporary node into the map to handle cycles.
            % Any recursive call for a neighbor that forms a cycle back to Node.val
            % will retrieve this TempClonedNode.
            AccMap1 = maps:put(Node.val, TempClonedNode, AccMap),

            % Recursively clone neighbors, threading the map.
            % This will return a list of cloned neighbors and the final map after processing them.
            {ClonedNeighbors, AccMap2} = clone_list_of_nodes(Node.neighbors, AccMap1),

            % Create the final cloned node with the correct neighbors.
            % This is a NEW record, distinct from TempClonedNode due to Erlang's immutability.
            FinalClonedNode = TempClonedNode#node{neighbors = ClonedNeighbors},

            % Replace the TempClonedNode in the map with the FinalClonedNode.
            % This ensures that future lookups for Node.val get the complete node.
            AccMap3 = maps:put(Node.val, FinalClonedNode, AccMap2),

            {FinalClonedNode, AccMap3}
    end.

clone_list_of_nodes([], AccMap) ->
    {[], AccMap};
clone_list_of_nodes([H|T], AccMap) ->
    {ClonedH, AccMap1} = clone_graph_aux(H, AccMap),
    {ClonedT, AccMap2} = clone_list_of_nodes(T, AccMap1),
    {[ClonedH|ClonedT], AccMap2}.
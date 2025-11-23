-spec eventual_safe_nodes(Graph :: [[integer()]]) -> [integer()].
eventual_safe_nodes(Graph) ->
    N = length(Graph),
    Visited = array:new([{size, N}, {default, 0}]),
    Safe = array:new([{size, N}, {default, false}]),
    {SafeNodes, _} = lists:foldl(
        fun(Node, {SafeAcc, VisitedAcc}) ->
            case array:get(Node, VisitedAcc) of
                0 ->
                    {IsSafe, NewVisited} = dfs(Node, Graph, VisitedAcc, SafeAcc),
                    {array:set(Node, IsSafe, SafeAcc), NewVisited};
                _ ->
                    {SafeAcc, VisitedAcc}
            end
        end,
        {Safe, Visited},
        lists:seq(0, N - 1)
    ),
    lists:filter(fun(Node) -> array:get(Node, SafeNodes) end, lists:seq(0, N - 1)).

dfs(Node, Graph, Visited, Safe) ->
    NewVisited = array:set(Node, 1, Visited),
    IsSafe = lists:all(
        fun(Neighbor) ->
            case array:get(Neighbor, NewVisited) of
                1 -> false;
                2 -> array:get(Neighbor, Safe);
                _ ->
                    {NeighborIsSafe, VisitedAfter} = dfs(Neighbor, Graph, NewVisited, Safe),
                    NeighborIsSafe
            end
        end,
        array:get(Node, Graph)
    ),
    FinalVisited = array:set(Node, 2, NewVisited),
    {IsSafe, FinalVisited}.
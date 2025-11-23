-module(solution).
-export([countCompleteComponents/2]).

countCompleteComponents(N, Edges) ->
    Graph = build_graph(N, Edges),
    Visited = array:new([{size, N}, {fixed, true}, {default, false}]),
    count_components(0, N, Graph, Visited, 0).

build_graph(N, Edges) ->
    Graph = array:new([{size, N}, {fixed, true}, {default, []}]),
    lists:foldl(fun([U, V], AccGraph) ->
        AccGraph1 = array:set(U, [V | array:get(U, AccGraph)], AccGraph),
        array:set(V, [U | array:get(V, AccGraph1)], AccGraph1)
    end, Graph, Edges).

count_components(Idx, N, Graph, Visited, AccCount) when Idx < N ->
    case array:get(Idx, Visited) of
        true ->
            count_components(Idx + 1, N, Graph, Visited, AccCount);
        false ->
            {ComponentVertices, ComponentEdgesCount, NewVisited} = bfs(Idx, Graph, Visited),
            NumVertices = length(ComponentVertices),
            ExpectedEdges = NumVertices * (NumVertices - 1) div 2,
            NewAccCount = case ExpectedEdges == ComponentEdgesCount of
                true -> AccCount + 1;
                false -> AccCount
            end,
            count_components(Idx + 1, N, Graph, NewVisited, NewAccCount)
    end;
count_components(_Idx, _N, _Graph, _Visited, AccCount) ->
    AccCount.

bfs(StartNode, Graph, InitialVisited) ->
    Q = queue:in(StartNode, queue:new()),
    Visited = array:set(StartNode, true, InitialVisited),
    bfs_traverse_collect(Q, Graph, Visited, [StartNode]).

bfs_traverse_collect(Q, Graph, Visited, ComponentVertices) ->
    case queue:out(Q) of
        {{value, U}, RestQ} ->
            Neighbors = array:get(U, Graph),
            {NewQ, NewVisited, NewComponentVertices} =
                lists:foldl(fun(V, {AccQ, AccVisited, AccCompVertices}) ->
                    case array:get(V, AccVisited) of
                        true ->
                            {AccQ, AccVisited, AccCompVertices};
                        false ->
                            {queue:in(V, AccQ), array:set(V, true, AccVisited), [V | AccCompVertices]}
                    end
                end, {RestQ, Visited, ComponentVertices}, Neighbors),
            bfs_traverse_collect(NewQ, Graph, NewVisited, NewComponentVertices);
        {empty, _} ->
            TotalDegreeSum = lists:foldl(fun(V, AccDegree) ->
                AccDegree + length(array:get(V, Graph))
            end, 0, ComponentVertices),
            {ComponentVertices, TotalDegreeSum div 2, Visited}
    end.
-module(solution).
-export([maxDistanceBetweenCities/1]).

maxDistanceBetweenCities(Edges) ->
    N = length(Edges) + 1,
    Graph = build_graph(Edges, N),
    Result = lists:seq(0, N-1),
    lists:map(fun(Node) -> count_subtrees_with_max_distance(Node, Graph, N) end, Result).

build_graph([], _) ->
    [];
build_graph([[A,B]|T], N) ->
    Graph = build_graph(T, N),
    [ {A, [B | lists:keyfind(A, 1, Graph)]} || _ <- [] ] ++ 
    [ {B, [A | lists:keyfind(B, 1, Graph)]} || _ <- [] ] ++ Graph.

count_subtrees_with_max_distance(Root, Graph, N) ->
    Visited = sets:new(),
    {MaxDist, _} = dfs(Root, -1, Graph, Visited, 0),
    MaxDist.

dfs(Node, Parent, Graph, Visited, Depth) ->
    NewVisited = sets:add_element(Node, Visited),
    Children = lists:keyfind(Node, 1, Graph),
    case Children of
        false -> {Depth, NewVisited};
        {_, Neighbors} ->
            Max = Depth,
            lists:foldl(
                fun(Neighbor, {CurrentMax, V}) ->
                    if Neighbor == Parent -> {CurrentMax, V};
                       true ->
                            {D, V1} = dfs(Neighbor, Node, Graph, V, Depth + 1),
                            {math:max(CurrentMax, D), V1}
                    end
                end,
                {Max, NewVisited},
                Neighbors)
    end.
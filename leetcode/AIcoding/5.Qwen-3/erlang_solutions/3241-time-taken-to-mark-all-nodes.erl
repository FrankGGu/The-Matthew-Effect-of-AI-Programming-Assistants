-module(solution).
-export([time_taken/1]).

time_taken(Edges) ->
    N = length(Edges) + 1,
    Graph = build_graph(Edges, N),
    {MaxDepth, _} = dfs(0, -1, Graph, 0),
    MaxDepth.

build_graph([], _) -> [];
build_graph([[U, V] | T], N) ->
    [ {U, [V | lists:keyfind(U, 1, build_graph(T, N))]} | build_graph(T, N) ].

dfs(Node, Parent, Graph, Depth) ->
    MaxDepth = Depth,
    lists:foldl(
        fun({Child, _}, {CurrentMax, _}) ->
            if Child /= Parent ->
                {NewDepth, _} = dfs(Child, Node, Graph, Depth + 1),
                {max(CurrentMax, NewDepth), NewDepth};
            true ->
                {CurrentMax, Depth}
            end
    end, {MaxDepth, Depth}, Graph).
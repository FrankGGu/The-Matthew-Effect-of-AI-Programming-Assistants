-module(solution).
-export([maximal_path_quality/4]).

maximal_path_quality(Values, Edges, MaxTime) ->
    N = length(Values),
    Graph = build_graph(N, Edges),
    Visited = array:new([{size, N}, {default, 0}]),
    {MaxQuality, _} = dfs(0, 0, Values, Graph, MaxTime, Visited, 0, 0),
    MaxQuality.

build_graph(N, Edges) ->
    Graph = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V, T], G) ->
                    G1 = array:set(U, [{V, T} | array:get(U, G)], G),
                    array:set(V, [{U, T} | array:get(V, G1)], G1)
                end, Graph, Edges).

dfs(Node, Time, Values, Graph, MaxTime, Visited, Quality, MaxQuality) ->
    Visited1 = array:set(Node, array:get(Node, Visited) + 1, Visited),
    Quality1 = case array:get(Node, Visited1) == 1 of
                   true -> Quality + lists:nth(Node + 1, Values);
                   false -> Quality
               end,
    MaxQuality1 = case Node == 0 of
                      true -> max(Quality1, MaxQuality);
                      false -> MaxQuality
                  end,
    lists:foldl(fun({Next, T}, {MQ, _}) ->
                    case Time + T =< MaxTime of
                        true -> dfs(Next, Time + T, Values, Graph, MaxTime, Visited1, Quality1, MQ);
                        false -> {MQ, Time}
                    end
                end, {MaxQuality1, Time}, array:get(Node, Graph)).
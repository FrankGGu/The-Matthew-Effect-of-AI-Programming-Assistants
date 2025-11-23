-module(solution).
-export([count_visited_nodes/2]).

count_visited_nodes(N, Edges) ->
    Graph = lists:foldl(fun({A, B}, Acc) -> maps:update_with(A, fun(Adj) -> [B | Adj] end, fun() -> [B] end, Acc) end, maps:new(), Edges),
    count_visited_nodes_helper(Graph, N, 1, maps:empty(), maps:empty()).

count_visited_nodes_helper(Graph, N, Node, Visited, Count) when Node > N ->
    Count;
count_visited_nodes_helper(Graph, N, Node, Visited, Count) ->
    case maps:is_key(Node, Visited) of
        true -> count_visited_nodes_helper(Graph, N, Node + 1, Visited, Count);
        false ->
            NewVisited = maps:put(Node, true, Visited),
            AdjNodes = maps:get(Node, Graph, []),
            NewCount = Count + 1,
            lists:foldl(fun(AdjNode, Acc) -> count_visited_nodes_helper(Graph, N, AdjNode, NewVisited, Acc) end, NewCount, AdjNodes)
    end.
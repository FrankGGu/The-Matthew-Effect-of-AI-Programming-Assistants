-module(solution).
-export([distance_k/2]).

distance_k(Edges, K) ->
    Graph = build_graph(Edges),
    Nodes = lists:usort(lists:flatten(Edges)),
    Count = 0,
    lists:foldl(fun(Node, Acc) -> count_distances(Graph, Node, K, Acc) end, Count, Nodes).

build_graph(Edges) ->
    maps:new() ++ [ {A, maps:get(A, maps:new(), []) ++ [B]} || {A, B} <- Edges ] ++ [ {B, maps:get(B, maps:new(), []) ++ [A]} || {A, B} <- Edges ].

count_distances(_Graph, _Start, _K, Acc) when K == 0 ->
    Acc + 1;
count_distances(Graph, Start, K, Acc) ->
    Visited = sets:new(),
    Queue = queue:from_list([{Start, 0}]),
    count_distances_dfs(Graph, Start, K, Visited, Queue, Acc).

count_distances_dfs(_Graph, _Start, _K, _Visited, _Queue, Acc) when queue:is_empty(Queue) ->
    Acc;
count_distances_dfs(Graph, Start, K, Visited, Queue, Acc) ->
    { {value, {Node, Dist}}, NewQueue } = queue:out(Queue),
    case sets:is_element(Node, Visited) of
        true ->
            count_distances_dfs(Graph, Start, K, Visited, NewQueue, Acc);
        false ->
            NewVisited = sets:add_element(Node, Visited),
            case Dist of
                K ->
                    count_distances_dfs(Graph, Start, K, NewVisited, NewQueue, Acc + 1);
                _ ->
                    Children = maps:get(Node, Graph, []),
                    NewQueue2 = lists:foldl(fun(Child, Q) -> queue:in({Child, Dist + 1}, Q) end, NewQueue, Children),
                    count_distances_dfs(Graph, Start, K, NewVisited, NewQueue2, Acc)
            end
    end.
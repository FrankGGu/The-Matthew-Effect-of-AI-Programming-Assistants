-module(solution).
-export([get_ancestors/2]).

get_ancestors(N, Edges) ->
    Graph = build_graph(N, Edges),
    Ancestors = lists:map(fun(Node) -> get_node_ancestors(Node, Graph) end, lists:seq(0, N - 1)),
    lists:map(fun(Set) -> lists:sort(sets:to_list(Set)) end, Ancestors).

build_graph(N, Edges) ->
    Graph = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([From, To], G) ->
                        Neighbors = array:get(To, G),
                        array:set(To, [From | Neighbors], G)
                end, Graph, Edges).

get_node_ancestors(Node, Graph) ->
    Visited = sets:new(),
    Queue = queue:from_list([Node]),
    bfs(Queue, Graph, Visited).

bfs(Queue, Graph, Visited) ->
    case queue:is_empty(Queue) of
        true -> Visited;
        false ->
            {{value, Current}, Q} = queue:out(Queue),
            Neighbors = array:get(Current, Graph),
            {NewVisited, NewQueue} = lists:foldl(fun(Neighbor, {V, QAcc}) ->
                                                         case sets:is_element(Neighbor, V) of
                                                             true -> {V, QAcc};
                                                             false ->
                                                                 NewV = sets:add_element(Neighbor, V),
                                                                 NewQ = queue:in(Neighbor, QAcc),
                                                                 {NewV, NewQ}
                                                         end
                                                 end, {Visited, Q}, Neighbors),
            bfs(NewQueue, Graph, NewVisited)
    end.
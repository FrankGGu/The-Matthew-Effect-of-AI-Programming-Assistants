-module(graph).
-export([new/1, add_node/2, add_edge/3, shortest_path/3]).

-record(graph, {nodes = #{}, edges = #{}}).

new(N) ->
    #graph{nodes = lists:foldl(fun(I, Acc) -> Acc#{I => #{}} end, #{}, lists:seq(0, N - 1))}.

add_node(Graph, Node) ->
    #graph{Graph | nodes = maps:put(Graph#graph.nodes, Node, #{})}.

add_edge(Graph, From, To, Cost) ->
    #graph{Graph | edges = maps:update_with(From, fun(Edges) -> Edges#{To => Cost} end, #{To => Cost}, Graph#graph.edges)}.

shortest_path(Graph, Start, End) ->
    dijkstra(Graph, Start, End).

dijkstra(Graph, Start, End) ->
    Nodes = maps:keys(Graph#graph.nodes),
    Dist = lists:foldl(fun(Node, Acc) -> Acc#{Node => infinity} end, #{}, Nodes),
    Prev = lists:foldl(fun(Node, Acc) -> Acc#{Node => undefined} end, #{}, Nodes),
    Q = queue:from_list(Nodes),
    Dist1 = maps:put(Dist, Start, 0),
    dijkstra_loop(Graph, Q, Dist1, Prev, End).

dijkstra_loop(Graph, Q, Dist, Prev, End) ->
    case queue:is_empty(Q) of
        true ->
            case maps:get(End, Dist, infinity) of
                infinity -> -1;
                Val -> Val
            end;
        false ->
            {Value, Q1} = queue:out(Q),
            {Node, Q2} = Value,
            U = Node,
            Edges = maps:get(U, Graph#graph.edges, #{}),
            lists:foldl(fun({V, Weight}, {DistAcc, PrevAcc, QAcc}) ->
                                 Alt = maps:get(U, DistAcc) + Weight,
                                 case Alt < maps:get(V, DistAcc) of
                                     true ->
                                         {maps:put(V, Alt, DistAcc), maps:put(V, U, PrevAcc), queue:add(V, QAcc)};
                                     false ->
                                         {DistAcc, PrevAcc, QAcc}
                                 end
                         end, {Dist, Prev, Q1}, maps:to_list(Edges)),
            dijkstra_loop(Graph, queue:from_list(lists:usort(queue:to_list(Q2))), Dist, Prev, End)
    end.
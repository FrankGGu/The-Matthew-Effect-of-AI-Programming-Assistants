-module(reachable_nodes_in_subdivided_graph).
-export([reachable_nodes/2]).

reachable_nodes(Edges, M) ->
    Graph = build_graph(Edges),
    {Nodes, _} = lists:foldl(fun({From, To, _}, {Visited, Q}) ->
        case lists:keymember(From, 1, Visited) of
            true -> {Visited, Q};
            false -> {[{From, 0} | Visited], queue:in({From, 0}, Q)}
        end
    end, {[], queue:new()}, Edges),
    dfs(Graph, M, Visited, queue:to_list(Q)).

build_graph(Edges) ->
    lists:foldl(fun({From, To, K}, Acc) ->
        AddEdge = fun(Node, Value) ->
            case lists:keyfind(Node, 1, Acc) of
                false -> [{Node, Value} | Acc];
                {_, V} -> lists:keyreplace(Node, 1, Acc, {Node, V ++ [Value]}) 
            end
        end,
        AddEdge(From, {To, K}),
        AddEdge(To, {From, K})
    end, [], Edges).

dfs(_Graph, _M, Visited, []) ->
    length(Visited);
dfs(Graph, M, Visited, [{Node, Steps} | Rest]) ->
    case lists:keymember(Node, 1, Visited) of
        true -> dfs(Graph, M, Visited, Rest);
        false ->
            NewVisited = [{Node, Steps} | Visited],
            Neighbors = case lists:keyfind(Node, 1, Graph) of
                false -> [];
                {_, Ns} -> Ns
            end,
            NextQueue = lists:foldl(fun({Neighbor, K}, Acc) ->
                if
                    Steps + K =< M ->
                        case lists:keymember(Neighbor, 1, NewVisited) of
                            true -> Acc;
                            false -> queue:in({Neighbor, Steps + K}, Acc)
                        end;
                    true -> Acc
                end
            end, queue:new(), Neighbors),
            dfs(Graph, M, NewVisited, Rest ++ queue:to_list(NextQueue)).
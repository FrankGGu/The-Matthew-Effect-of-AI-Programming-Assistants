-module(solution).
-export([min_reorder/2]).

min_reorder(N, Connections) ->
    Graph = build_graph(N, Connections),
    {Visited, Count} = dfs(0, Graph, sets:new(), 0),
    Count.

build_graph(N, Connections) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun([From, To], Acc) ->
                    update_graph(From, To, 1, Acc),
                    update_graph(To, From, 0, Acc)
                end, Graph, Connections).

update_graph(From, To, Dir, Graph) ->
    Existing = lists:nth(From + 1, Graph),
    lists:sublist(Graph, From) ++ [[{To, Dir} | Existing]] ++ lists:nthtail(From + 1, Graph).

dfs(Node, Graph, Visited, Count) ->
    case sets:is_element(Node, Visited) of
        true -> {Visited, Count};
        false ->
            NewVisited = sets:add_element(Node, Visited),
            lists:foldl(fun({Neighbor, Dir}, {V, C}) ->
                            case Dir of
                                1 -> dfs(Neighbor, Graph, V, C + 1);
                                0 -> dfs(Neighbor, Graph, V, C)
                            end
                        end, {NewVisited, Count}, lists:nth(Node + 1, Graph))
    end.
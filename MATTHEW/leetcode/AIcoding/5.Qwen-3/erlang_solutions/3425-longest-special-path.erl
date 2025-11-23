-module(longest_special_path).
-export([longest_path/1]).

longest_path(Graph) ->
    Max = 0,
    Nodes = maps:keys(Graph),
    lists:foldl(fun(Node, Acc) -> max(Acc, dfs(Node, Graph, #{})) end, Max, Nodes).

dfs(Node, Graph, Visited) ->
    case maps:is_key(Node, Visited) of
        true -> 0;
        false ->
            NewVisited = maps:put(Node, true, Visited),
            Neighbors = maps:get(Node, Graph, []),
            lists:foldl(fun(Neighbor, Acc) ->
                            if
                                maps:get(Neighbor, Graph, []) == [] -> Acc + 1;
                                true -> max(Acc, dfs(Neighbor, Graph, NewVisited))
                            end
                        end, 1, Neighbors)
    end.
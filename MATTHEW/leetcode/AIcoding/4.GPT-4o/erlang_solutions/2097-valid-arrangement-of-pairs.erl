-module(solution).
-export([validArrangement/1]).

validArrangement(Pairs) ->
    Graph = build_graph(Pairs),
    StartNode = find_start_node(Graph),
    Path = eulerian_path(Graph, StartNode),
    lists:map(fun({X, Y}) -> {X, Y} end, Path).

build_graph(Pairs) ->
    Graph = lists:foldl(fun({X, Y}, Acc) ->
        maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc)
    end, #{} , Pairs),
    Graph.

find_start_node(Graph) ->
    lists:foldl(fun({Node, Count}, {StartNode, OddCount}) ->
        case Count rem 2 of
            1 -> {Node, OddCount + 1};
            _ -> {StartNode, OddCount}
        end
    end, {undefined, 0}, maps:to_list(Graph)).

eulerian_path(Graph, StartNode) ->
    Path = [],
    dfs(Graph, StartNode, Path).

dfs(Graph, Node, Path) ->
    case maps:get(Node, Graph, []) of
        [] -> [{Node, NextNode} | Path];
        [NextNode | Rest] ->
            Graph1 = maps:update(Node, fun(L) -> tl(L) end, [], Graph),
            dfs(Graph1, NextNode, [{Node, NextNode} | Path])
    end.
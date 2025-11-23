-module(solution).
-export([most_profitable_path/3]).

most_profitable_path(Tree, Start, Target) ->
    Graph = build_graph(Tree),
    Profits = get_profits(Tree),
    bfs(Graph, Profits, Start, Target, 0, []).

build_graph(Tree) ->
    lists:foldl(fun({Parent, Children}, Acc) ->
        lists:foldl(fun(Child, Acc1) ->
            maps:put(Parent, [Child | maps:get(Parent, Acc1, [])], Acc1)
        end, Acc, Children)
    end, maps:new(), Tree).

get_profits(Tree) ->
    lists:foldl(fun({Node, Profit}, Acc) ->
        maps:put(Node, Profit, Acc)
    end, maps:new(), Tree).

bfs(Graph, Profits, Start, Target, Visited, Path) ->
    case lists:member(Start, Visited) of
        true -> {undefined};
        false ->
            NewVisited = [Start | Visited],
            if
                Start =:= Target -> 
                    lists:reverse([Start | Path]);
                true -> 
                    case maps:get(Start, Graph, []) of
                        [] -> {undefined};
                        Neighbors ->
                            lists:foldl(fun(Neighbor, Acc) ->
                                case bfs(Graph, Profits, Neighbor, Target, NewVisited, [Start | Path]) of
                                    {undefined} -> Acc;
                                    Res -> lists:append(Acc, [Res])
                                end
                            end, [], Neighbors)
                    end
            end
    end.
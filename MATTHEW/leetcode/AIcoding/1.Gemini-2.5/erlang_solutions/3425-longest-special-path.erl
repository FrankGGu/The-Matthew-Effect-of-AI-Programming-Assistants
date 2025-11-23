-module(solution).
-export([longestSpecialPath/2]).

longestSpecialPath(_N, Edges) ->
    Graph = build_graph(Edges),
    MemoTable = ets:new(longest_path_memo, [set, public, {read_concurrency, true}]),
    AllNodes = get_all_nodes(Graph),
    MaxPath = lists:foldl(fun(Node, Acc) ->
                                Max = find_longest_path_from_node(Node, Graph, MemoTable),
                                max(Acc, Max)
                          end, 0, AllNodes),
    ets:delete(MemoTable),
    MaxPath.

build_graph(Edges) ->
    lists:foldl(fun({U, V}, Acc) ->
                    maps:update_with(U, fun(Val) -> [V | Val] end, [V], Acc)
                end, #{}, Edges).

get_all_nodes(Graph) ->
    Nodes = maps:keys(Graph),
    Neighbors = lists:flatten(maps:values(Graph)),
    lists:usort(Nodes ++ Neighbors).

find_longest_path_from_node(Node, Graph, MemoTable) ->
    case ets:lookup(MemoTable, Node) of
        [{Node, Length}] -> Length;
        [] ->
            Neighbors = maps:get(Node, Graph, []),
            Result = case Neighbors of
                [] -> 0;
                _ ->
                    MaxNeighborPath = lists:foldl(fun(Neighbor, Acc) ->
                                                      Path = find_longest_path_from_node(Neighbor, Graph, MemoTable),
                                                      max(Acc, Path)
                                                  end, -1, Neighbors),
                    case MaxNeighborPath of
                        -1 -> 0;
                        _ -> 1 + MaxNeighborPath
                    end
            end,
            ets:insert(MemoTable, {Node, Result}),
            Result
    end.
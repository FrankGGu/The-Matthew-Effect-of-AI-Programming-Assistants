-module(count_valid_paths_in_a_tree).
-export([countValidPaths/1]).

countValidPaths(Edges) ->
    NodeCount = length(Edges) + 1,
    Graph = build_graph(Edges, NodeCount),
    Count = 0,
    dfs(1, -1, Graph, Count, 0).

build_graph([], _) -> [];
build_graph([[A,B]|T], N) ->
    Graph = build_graph(T, N),
    AList = case lists:keyfind(A, 1, Graph) of
                false -> {A, []};
                {_, L} -> {A, L}
            end,
    BList = case lists:keyfind(B, 1, Graph) of
                false -> {B, []};
                {_, L} -> {B, L}
            end,
    NewGraph = lists:keystore(A, 1, Graph, {A, [B | AList#tuple.2]}),
    NewGraph2 = lists:keystore(B, 1, NewGraph, {B, [A | BList#tuple.2]}),
    NewGraph2.

dfs(Node, Parent, Graph, Count, Depth) ->
    Children = case lists:keyfind(Node, 1, Graph) of
                   false -> [];
                   {_, L} -> L
               end,
    Valid = true,
    if
        Depth >= 2, Valid -> Count + 1;
        true ->
            NewCount = Count,
            lists:foldl(fun(Child, Acc) ->
                            if
                                Child /= Parent ->
                                    dfs(Child, Node, Graph, Acc, Depth + 1);
                                true -> Acc
                            end
                        end, NewCount, Children)
    end.
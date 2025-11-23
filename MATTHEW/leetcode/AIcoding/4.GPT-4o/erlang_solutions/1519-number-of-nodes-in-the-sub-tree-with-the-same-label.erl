-module(solution).
-export([countSubTrees/3]).

countSubTrees(Nodes, Edges, Labels) ->
    Graph = build_graph(Nodes, Edges),
    LabelsList = lists:map(fun(X) -> {X, 0} end, lists:seq(1, Nodes)),
    Count = count_labels(Graph, Labels, LabelsList),
    lists:map(fun({_, C}) -> C end, Count).

build_graph(Nodes, Edges) ->
    lists:foldl(fun({X, Y}, Acc) ->
        maps:update(X, [Y | maps:get(X, Acc, [])], Acc)
    end, maps:from_list(lists:map(fun(X) -> {X, []} end, lists:seq(1, Nodes))), Edges).

count_labels(Graph, Labels, Counts) ->
    lists:foldl(fun({Node, Label}, Acc) ->
        count_label(Node, Label, Graph, Acc)
    end, Counts, lists:zip(lists:seq(1, length(Labels)), Labels)).

count_label(Node, Label, Graph, Counts) ->
    case maps:get(Node, Graph) of
        Neighbors ->
            SubCount = lists:foldl(fun(Neighbor, Acc) ->
                case lists:keyfind(Neighbor, 1, Acc) of
                    {_, C} -> [{Neighbor, C + 1} | Acc];
                    _ -> Acc
                end
            end, Counts, Neighbors),
            lists:keyreplace(Node, 1, SubCount, Counts);
    end.
-module(valid_arrangement_of_pairs).
-export([findValidArrangement/1]).

findValidArrangement(Pairs) ->
    Graph = build_graph(Pairs),
    InDegree = build_in_degree(Graph),
    OutDegree = build_out_degree(Graph),
    StartNode = find_start_node(Graph, InDegree, OutDegree),
    Path = eulerian_path(Graph, StartNode),
    lists:reverse(Path).

build_graph(Pairs) ->
    maps:fold(
        fun({A, B}, _, Acc) ->
            maps:update_with(A, fun(Val) -> [B | Val] end, [B], Acc)
        end,
        #{},
        Pairs
    ).

build_in_degree(Graph) ->
    maps:fold(
        fun(_, [H | _], Acc) ->
            maps:update_with(H, fun(V) -> V + 1 end, 1, Acc);
           (_, [], Acc) ->
            Acc
        end,
        #{},
        Graph
    ).

build_out_degree(Graph) ->
    maps:fold(
        fun(_, Val, Acc) ->
            maps:update_with(self(), fun(V) -> V + length(Val) end, length(Val), Acc)
        end,
        #{},
        Graph
    ).

find_start_node(Graph, InDegree, OutDegree) ->
    maps:fold(
        fun(Node, _, Acc) ->
            case maps:get(Node, OutDegree, 0) - maps:get(Node, InDegree, 0) of
                1 -> {value, Node};
                _ -> Acc
            end
        end,
        undefined,
        Graph
    ).

eulerian_path(Graph, Start) ->
    Path = [],
    eulerian_traversal(Graph, Start, Path).

eulerian_traversal(Graph, Node, Path) ->
    case maps:get(Node, Graph, []) of
        [] ->
            [Node | Path];
        [Next | Rest] ->
            NewGraph = maps:update(Node, Rest, Graph),
            eulerian_traversal(NewGraph, Next, [Node | Path])
    end.
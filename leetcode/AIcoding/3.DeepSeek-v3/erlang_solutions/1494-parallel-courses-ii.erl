-module(solution).
-export([min_number_of_semesters/3]).

min_number_of_semesters(N, Dependencies, K) ->
    Graph = build_graph(N, Dependencies),
    InDegree = build_in_degree(N, Dependencies),
    TopoOrder = kahn_topological_sort(N, Graph, InDegree, K),
    length(TopoOrder).

build_graph(N, Dependencies) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun([U, V], Acc) ->
                    update_element(Acc, U - 1, [V - 1 | element(U - 1, Acc)])
                end, list_to_tuple(Graph), Dependencies).

build_in_degree(N, Dependencies) ->
    InDegree = lists:duplicate(N, 0),
    lists:foldl(fun([_, V], Acc) ->
                    update_element(Acc, V - 1, element(V - 1, Acc) + 1)
                end, list_to_tuple(InDegree), Dependencies).

update_element(Tuple, Index, Value) ->
    list_to_tuple(lists:sublist(tuple_to_list(Tuple), Index) ++ [Value] ++ lists:nthtail(Index + 1, tuple_to_list(Tuple))).

kahn_topological_sort(N, Graph, InDegree, K) ->
    case get_zero_indegree_nodes(InDegree) of
        [] -> [];
        ZeroNodes ->
            {Selected, Remaining} = select_nodes(ZeroNodes, K),
            NewInDegree = update_in_degree(Selected, Graph, InDegree),
            [Selected | kahn_topological_sort(N, Graph, NewInDegree, K)]
    end.

get_zero_indegree_nodes(InDegree) ->
    lists:filtermap(fun(I) ->
                        case element(I, InDegree) of
                            0 -> {true, I};
                            _ -> false
                        end
                    end, lists:seq(0, tuple_size(InDegree) - 1)).

select_nodes(Nodes, K) ->
    Selected = lists:sublist(Nodes, K),
    Remaining = lists:nthtail(K, Nodes),
    {Selected, Remaining}.

update_in_degree(Selected, Graph, InDegree) ->
    lists:foldl(fun(U, Acc) ->
                    lists:foldl(fun(V, Acc2) ->
                                    update_element(Acc2, V, element(V, Acc2) - 1)
                                end, Acc, element(U, Graph))
                end, InDegree, Selected).
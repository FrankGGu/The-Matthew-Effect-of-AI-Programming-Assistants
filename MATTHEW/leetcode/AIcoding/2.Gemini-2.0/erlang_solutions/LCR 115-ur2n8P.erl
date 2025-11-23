-module(solution).
-export([sequence_reconstruction/2]).

sequence_reconstruction(org, seqs) ->
    Vertices = lists:usort(lists:flatten(seqs)),
    Graph = create_graph(seqs),
    InDegree = calculate_in_degree(Vertices, Graph),

    queue:is_queue(Q0) -> Q0;
    queue:new().

    Q = lists:foldl(fun(V, Acc) -> 
                           case maps:get(V, InDegree, 0) of
                               0 -> queue:in(V, Acc);
                               _ -> Acc
                           end
                       end, new_queue(), Vertices),

    reconstruct(org, Graph, InDegree, Q, []).

create_graph(Seqs) ->
    lists:foldl(fun(Seq, Acc) ->
                        create_edges(Seq, Acc)
                end, #{}, Seqs).

create_edges([_], Graph) ->
    Graph;
create_edges([H1, H2 | T], Graph) ->
    NewGraph = maps:update_with(H1, fun(Neighbors) -> lists:usort([H2 | Neighbors]) end, [H2], Graph),
    create_edges([H2 | T], NewGraph).

calculate_in_degree(Vertices, Graph) ->
    lists:foldl(fun(V, Acc) ->
                        case maps:get(V, Acc, undefined) of
                            undefined -> maps:put(V, 0, Acc);
                            _ -> Acc
                        end
                end, #{}, Vertices)

    lists:foldl(fun(V, Acc) ->
                    case maps:get(V, Graph, []) of
                        [] -> Acc;
                        Neighbors ->
                            lists:foldl(fun(Neighbor, Acc2) ->
                                            maps:update_with(Neighbor, fun(Degree) -> Degree + 1 end, 1, Acc2)
                                        end, Acc, Neighbors)
                    end
                end, InDegree0, Vertices).

reconstruct(Org, Graph, InDegree, Q, Acc) ->
    case queue:is_empty(Q) of
        true ->
            case Acc =:= Org of
                true -> true;
                false -> false
            end;
        false ->
            {V, Q1} = queue:out(Q),
            case queue:len(Q) > 0 of
                true -> false;
                false ->
                    Neighbors = maps:get(V, Graph, []),
                    UpdatedInDegree = lists:foldl(fun(Neighbor, Acc2) ->
                                                      case maps:get(Neighbor, Acc2) of
                                                          Degree -> maps:put(Neighbor, Degree - 1, Acc2)
                                                      end
                                                  end, InDegree, Neighbors),
                    Q2 = lists:foldl(fun(Neighbor, Acc2) ->
                                          case maps:get(Neighbor, UpdatedInDegree) of
                                              0 -> queue:in(Neighbor, Acc2);
                                              _ -> Acc2
                                          end
                                      end, Q1, Neighbors),
                    reconstruct(Org, Graph, UpdatedInDegree, Q2, Acc ++ [V])
            end
    end.
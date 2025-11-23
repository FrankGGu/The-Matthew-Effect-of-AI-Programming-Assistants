-spec sequence_reconstruction(Nums :: [integer()], Sequences :: [[integer()]]) -> boolean().
sequence_reconstruction(Nums, Sequences) ->
    case Nums of
        [] -> true;
        _ ->
            case Sequences of
                [] -> false;
                _ ->
                    N = length(Nums),
                    InDegree = maps:from_list([{X, 0} || X <- lists:seq(1, N)]),
                    Graph = maps:from_list([{X, []} || X <- lists:seq(1, N)]),
                    {UpdatedGraph, UpdatedInDegree} = build_graph(Sequences, Graph, InDegree),
                    Queue = [X || X <- lists:seq(1, N), maps:get(X, UpdatedInDegree) =:= 0],
                    case Queue of
                        [H] -> check_topological_sort(H, UpdatedGraph, UpdatedInDegree, Nums);
                        _ -> false
                    end
            end
    end.

build_graph([], Graph, InDegree) -> {Graph, InDegree};
build_graph([Seq | Rest], Graph, InDegree) ->
    {NewGraph, NewInDegree} = process_sequence(Seq, Graph, InDegree),
    build_graph(Rest, NewGraph, NewInDegree).

process_sequence([_], Graph, InDegree) -> {Graph, InDegree};
process_sequence([U, V | Tail], Graph, InDegree) ->
    case lists:member(V, maps:get(U, Graph)) of
        false ->
            NewGraph = maps:put(U, [V | maps:get(U, Graph)], Graph),
            NewInDegree = maps:put(V, maps:get(V, InDegree) + 1, InDegree),
            process_sequence([V | Tail], NewGraph, NewInDegree);
        true ->
            process_sequence([V | Tail], Graph, InDegree)
    end.

check_topological_sort(Start, Graph, InDegree, Nums) ->
    Queue = [Start],
    check_topological_sort(Queue, Graph, InDegree, Nums, 0).

check_topological_sort([], _, _, _, Index) -> Index =:= length(Nums);
check_topological_sort([H | T], Graph, InDegree, Nums, Index) ->
    case Index >= length(Nums) orelse H =/= lists:nth(Index + 1, Nums) of
        true -> false;
        false ->
            NewInDegree = decrement_in_degree(H, Graph, InDegree),
            NewQueue = T ++ [X || X <- maps:get(H, Graph), maps:get(X, NewInDegree) =:= 0],
            check_topological_sort(NewQueue, Graph, NewInDegree, Nums, Index + 1)
    end.

decrement_in_degree(Node, Graph, InDegree) ->
    lists:foldl(fun(Neighbor, Acc) ->
        maps:put(Neighbor, maps:get(Neighbor, Acc) - 1, Acc)
    end, InDegree, maps:get(Node, Graph)).
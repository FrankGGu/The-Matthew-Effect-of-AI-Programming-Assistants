-module(solution).
-export([max_probability/4]).

max_probability(N, Edges, SuccProb, Start, End) ->
    Graph = build_graph(N, Edges, SuccProb),
    Prob = maps:from_list([{Node, 0.0} || Node <- lists:seq(0, N-1)]),
    UpdatedProb = maps:put(Start, 1.0, Prob),
    Queue = [{1.0, Start}],
    dijkstra(Queue, UpdatedProb, Graph, End).

build_graph(N, Edges, SuccProb) ->
    Graph = maps:from_list([{Node, []} || Node <- lists:seq(0, N-1)]),
    lists:foldl(fun({Edge, Prob}, Acc) ->
        {U, V} = Edge,
        Acc1 = maps:update_with(U, fun(Neighbors) -> [{V, Prob} | Neighbors] end, Acc),
        maps:update_with(V, fun(Neighbors) -> [{U, Prob} | Neighbors] end, Acc1)
    end, Graph, lists:zip(Edges, SuccProb)).

dijkstra([], Prob, _, _) ->
    maps:get(End, Prob, 0.0) when is_map_key(End, Prob) -> maps:get(End, Prob, 0.0);
dijkstra(Queue, Prob, Graph, End) ->
    {CurrentProb, CurrentNode} = hd(lists:reverse(lists:keysort(1, Queue))),
    case CurrentNode =:= End of
        true -> CurrentProb;
        false ->
            NewQueue = lists:delete({CurrentProb, CurrentNode}, Queue),
            Neighbors = maps:get(CurrentNode, Graph, []),
            {UpdatedProb, UpdatedQueue} = lists:foldl(fun({Neighbor, EdgeProb}, {ProbAcc, QueueAcc}) ->
                NewProb = CurrentProb * EdgeProb,
                case NewProb > maps:get(Neighbor, ProbAcc, 0.0) of
                    true ->
                        NewProbAcc = maps:put(Neighbor, NewProb, ProbAcc),
                        NewQueueAcc = [{NewProb, Neighbor} | QueueAcc],
                        {NewProbAcc, NewQueueAcc};
                    false -> {ProbAcc, QueueAcc}
                end
            end, {Prob, NewQueue}, Neighbors),
            dijkstra(UpdatedQueue, UpdatedProb, Graph, End)
    end.
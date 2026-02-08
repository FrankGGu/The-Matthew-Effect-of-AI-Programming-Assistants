-module(alien_order).
-export([alien_order/1]).

alien_order(Words) ->
    {Graph, InDegree} = build_graph(Words),
    topological_sort(Graph, InDegree).

build_graph(Words) ->
    Chars = lists:usort(lists:flatten(Words)),
    Graph = dict:new(),
    InDegree = dict:new(),
    lists:foreach(fun(C) ->
                          dict:store(C, [], Graph),
                          dict:store(C, 0, InDegree)
                  end, Chars),

    lists:foreach(fun({W1, W2}) ->
                          process_pair(W1, W2, Graph, InDegree)
                  end, lists:zip(Words, tl(Words))),

    {Graph, InDegree}.

process_pair([], [], _, _) ->
    ok;
process_pair([], _, _, _) ->
    ok;
process_pair(_, [], _, _) ->
    ok;
process_pair([C1 | Rest1], [C2 | Rest2], Graph, InDegree) ->
    if
        C1 == C2 ->
            process_pair(Rest1, Rest2, Graph, InDegree);
        true ->
            Neighbors = dict:fetch(C1, Graph),
            if
                lists:member(C2, Neighbors) ->
                    ok;
                true ->
                    dict:store(C1, [C2 | Neighbors], Graph),
                    Count = dict:fetch(C2, InDegree) + 1,
                    dict:store(C2, Count, InDegree)
            end
    end.

topological_sort(Graph, InDegree) ->
    Queue = [C || {C, 0} <- dict:to_list(InDegree)],
    topological_sort_helper(Queue, Graph, InDegree, []).

topological_sort_helper([], Graph, InDegree, Acc) ->
    if
        dict:size(InDegree) == length(Acc) then
            lists:reverse(Acc)
        else
            ""
    end;
topological_sort_helper([C | Rest], Graph, InDegree, Acc) ->
    Neighbors = dict:fetch(C, Graph),
    NewInDegree = lists:foldl(fun(Neighbor, AccInDegree) ->
                                      Count = dict:fetch(Neighbor, AccInDegree) - 1,
                                      dict:store(Neighbor, Count, AccInDegree)
                              end, InDegree, Neighbors),

    NewQueue = Rest ++ [N || {N, 0} <- dict:to_list(NewInDegree)],
    NewInDegree2 = dict:filter(fun(_, V) -> V >= 0 end, NewInDegree),
    topological_sort_helper(NewQueue, Graph, NewInDegree2, [C | Acc]).
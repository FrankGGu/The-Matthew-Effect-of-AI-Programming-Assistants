-module(solution).
-export([min_reorder/2]).

min_reorder(N, Connections) ->
    Adj = build_adjacency(N, Connections),
    {Visited, Queue} = {array:new(N, {default, false}), queue:in(0, queue:new())},
    array:set(0, true, Visited),
    traverse(Adj, Queue, Visited, 0).

build_adjacency(N, Connections) ->
    Adj = array:new(N, {default, []}),
    lists:foldl(fun([From, To], Acc) ->
                    Acc1 = array:set(From, [{To, out} | array:get(From, Acc)], Acc),
                    array:set(To, [{From, in} | array:get(To, Acc1)], Acc1)
                end, Adj, Connections).

traverse(Adj, Queue, Visited, Count) ->
    case queue:out(Queue) of
        {empty, _} -> Count;
        {{value, Node}, Q} ->
            lists:foldl(fun({Neighbor, Dir}, {QAcc, VAcc, CAcc}) ->
                            case array:get(Neighbor, VAcc) of
                                false ->
                                    NewVAcc = array:set(Neighbor, true, VAcc),
                                    NewQAcc = queue:in(Neighbor, QAcc),
                                    NewCAcc = case Dir of out -> CAcc + 1; in -> CAcc end,
                                    {NewQAcc, NewVAcc, NewCAcc};
                                true ->
                                    {QAcc, VAcc, CAcc}
                            end
                        end, {Q, Visited, Count}, array:get(Node, Adj)),
            traverse(Adj, Q1, Visited1, Count1)
    end.
-module(solution).
-export([min_cost/3]).

min_cost(MaxTime, Edges, PassingFees) ->
    N = length(PassingFees),
    Graph = build_graph(Edges, N),
    DP = array:new([{size, N}, {default, infinity}]),
    DP1 = array:set(0, PassingFees, DP),
    PriorityQueue = gb_sets:new(),
    PriorityQueue1 = gb_sets:insert({PassingFees, 0, 0}, PriorityQueue),
    process_queue(MaxTime, Graph, PassingFees, DP1, PriorityQueue1).

build_graph(Edges, N) ->
    Graph = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V, Time], Acc) ->
        Acc1 = array:set(U, [{V, Time} | array:get(U, Acc)], Acc),
        array:set(V, [{U, Time} | array:get(V, Acc1)], Acc1)
    end, Graph, Edges).

process_queue(MaxTime, Graph, PassingFees, DP, PriorityQueue) ->
    case gb_sets:is_empty(PriorityQueue) of
        true -> -1;
        false ->
            {{Cost, Time, U}, PriorityQueue1} = gb_sets:take_smallest(PriorityQueue),
            if
                U == length(PassingFees) - 1 -> Cost;
                true ->
                    Neighbors = array:get(U, Graph),
                    {NewDP, NewQueue} = lists:foldl(
                        fun({V, EdgeTime}, {DPAcc, QueueAcc}) ->
                            NewTime = Time + EdgeTime,
                            if
                                NewTime > MaxTime -> {DPAcc, QueueAcc};
                                true ->
                                    NewCost = Cost + array:get(V, PassingFees),
                                    CurrentCost = array:get(V, DPAcc),
                                    if
                                        NewCost < CurrentCost ->
                                            NewDPAcc = array:set(V, NewCost, DPAcc),
                                            NewQueueAcc = gb_sets:add({NewCost, NewTime, V}, QueueAcc),
                                            {NewDPAcc, NewQueueAcc};
                                        true -> {DPAcc, QueueAcc}
                                    end
                            end
                        end,
                        {DP, PriorityQueue1},
                        Neighbors
                    ),
                    process_queue(MaxTime, Graph, PassingFees, NewDP, NewQueue)
            end
    end.
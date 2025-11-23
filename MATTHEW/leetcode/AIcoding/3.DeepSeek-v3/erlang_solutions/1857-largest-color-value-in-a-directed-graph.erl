-module(solution).
-export([largest_path_value/2]).

largest_path_value(Colors, Edges) ->
    N = length(Colors),
    Graph = build_graph(N, Edges),
    InDegree = count_in_degree(N, Edges),
    Queue = initialize_queue(InDegree),
    ColorsList = string:to_graphemes(Colors),
    DP = initialize_dp(N, ColorsList),
    process_topological_sort(Queue, Graph, InDegree, DP, ColorsList, 0).

build_graph(N, Edges) ->
    Graph = array:new([{size, N}, {default, []}]),
    lists:foldl(fun([U, V], G) ->
                    Neighbors = array:get(U, G),
                    array:set(U, [V | Neighbors], G)
                end, Graph, Edges).

count_in_degree(N, Edges) ->
    InDegree = array:new([{size, N}, {default, 0}]),
    lists:foldl(fun([_, V], ID) ->
                    Curr = array:get(V, ID),
                    array:set(V, Curr + 1, ID)
                end, InDegree, Edges).

initialize_queue(InDegree) ->
    array:foldl(fun(Node, Count, Q) ->
                    case Count of
                        0 -> [Node | Q];
                        _ -> Q
                    end
                end, [], InDegree).

initialize_dp(N, ColorsList) ->
    DP = array:new([{size, N}]),
    array:map(fun(_, _) -> maps:new() end, DP).

process_topological_sort([], _, _, _, _, Max) -> Max;
process_topological_sort(Queue, Graph, InDegree, DP, ColorsList, Max) ->
    {NewQueue, NewDP, NewMax} = 
        lists:foldl(fun(Node, {Q, DPAcc, CurrentMax}) ->
            Neighbors = array:get(Node, Graph),
            Color = lists:nth(Node + 1, ColorsList),
            NodeDP = array:get(Node, DPAcc),
            UpdatedNodeDP = maps:update_with(Color, fun(V) -> V + 1 end, 1, NodeDP),
            NewDPAcc = array:set(Node, UpdatedNodeDP, DPAcc),
            NewCurrentMax = max(CurrentMax, maps:get(Color, UpdatedNodeDP)),
            {NewQ, NewDPAcc2} = process_neighbors(Neighbors, Node, InDegree, NewDPAcc, Q),
            {NewQ, NewDPAcc2, NewCurrentMax}
        end, {[], DP, Max}, Queue),
    process_topological_sort(NewQueue, Graph, InDegree, NewDP, ColorsList, NewMax).

process_neighbors([], _, _, DP, Queue) -> {Queue, DP};
process_neighbors([V | Rest], U, InDegree, DP, Queue) ->
    CurrInDegree = array:get(V, InDegree) - 1,
    NewInDegree = array:set(V, CurrInDegree, InDegree),
    U_DP = array:get(U, DP),
    V_DP = array:get(V, DP),
    NewV_DP = maps:fold(fun(Color, Count, Acc) ->
        maps:update_with(Color, fun(Old) -> max(Old, Count) end, Count, Acc)
    end, V_DP, U_DP),
    NewDP = array:set(V, NewV_DP, DP),
    case CurrInDegree of
        0 -> process_neighbors(Rest, U, NewInDegree, NewDP, [V | Queue]);
        _ -> process_neighbors(Rest, U, NewInDegree, NewDP, Queue)
    end.
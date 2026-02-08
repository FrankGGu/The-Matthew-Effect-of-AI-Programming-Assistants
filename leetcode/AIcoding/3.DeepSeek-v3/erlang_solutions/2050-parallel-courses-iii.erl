-module(solution).
-export([minimum_time/2]).

minimum_time(N, Relations) ->
    InDegree = array:new([{size, N + 1}, {default, 0}]),
    Graph = build_graph(N, Relations, InDegree),
    Queue = initialize_queue(N, InDegree),
    TopoOrder = topological_sort(Graph, Queue, array:new([{size, N + 1}, {default, 0}])),
    lists:max(array:to_list(TopoOrder)).

build_graph(N, Relations, InDegree) ->
    Graph = array:new([{size, N + 1}, {default, []}]),
    lists:foldl(fun([U, V], Acc) ->
        NewAcc = array:set(U, [V | array:get(U, Acc)], Acc),
        array:set(V, array:get(V, InDegree) + 1, InDegree),
        NewAcc
    end, Graph, Relations).

initialize_queue(N, InDegree) ->
    lists:foldl(fun(I, Acc) ->
        case array:get(I, InDegree) of
            0 -> [I | Acc];
            _ -> Acc
        end
    end, [], lists:seq(1, N)).

topological_sort(Graph, [], Time) -> Time;
topological_sort(Graph, [U | Queue], Time) ->
    NewTime = array:set(U, array:get(U, Time) + 1, Time),
    lists:foldl(fun(V, {Q, T}) ->
        NewInDegree = array:get(V, T) - 1,
        NewT = array:set(V, NewInDegree, T),
        case NewInDegree of
            0 -> {[V | Q], NewT};
            _ -> {Q, NewT}
        end
    end, {Queue, NewTime}, array:get(U, Graph)),
    topological_sort(Graph, element(1, {Queue, NewTime}), element(2, {Queue, NewTime})).
-module(solution).
-export([parallel_courses/2]).

parallel_courses(N, Relations) ->
    Graph = build_graph(Relations),
    InDegree = build_indegree(Relations, N),
    queue_init(N, InDegree, Graph).

build_graph(Relations) ->
    lists:foldl(fun({U, V}, Acc) ->
        Maps = maps:get(U, Acc, #{}),
        NewMaps = maps:put(V, 1, Maps),
        maps:put(U, NewMaps, Acc)
    end, #{}, Relations).

build_indegree(Relations, N) ->
    InDegree = lists:seq(1, N),
    lists:foldl(fun({U, V}, Acc) ->
        maps:update_with(V, fun(X) -> X - 1 end, Acc)
    end, maps:from_list([{I, 0} || I <- InDegree]), Relations).

queue_init(N, InDegree, Graph) ->
    Queue = lists:filter(fun(I) -> maps:get(I, InDegree) == 0 end, lists:seq(1, N)),
    do_topo_sort(Queue, InDegree, Graph, 0, 0).

do_topo_sort([], _, _, Time, MaxTime) ->
    MaxTime;
do_topo_sort([Node | Rest], InDegree, Graph, Time, MaxTime) ->
    NextNodes = maps:get(Node, Graph, #{}),
    NewInDegree = maps:map(fun(K, V) ->
        if K == Node -> V;
           true -> V
        end
    end, InDegree),
    NewMaxTime = max(MaxTime, Time + 1),
    lists:foreach(fun(V) ->
        NewInDegree1 = maps:update_with(V, fun(X) -> X - 1 end, NewInDegree),
        case maps:get(V, NewInDegree1) of
            0 -> do_topo_sort([V | Rest], NewInDegree1, Graph, Time + 1, NewMaxTime);
            _ -> ok
        end
    end, maps:keys(NextNodes)),
    do_topo_sort(Rest, NewInDegree, Graph, Time, NewMaxTime).
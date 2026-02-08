-module(parallel_courses_ii).
-export([max_courses/2]).

max_courses(N, Dependencies) ->
    Graph = build_graph(N, Dependencies),
    InDegree = build_indegree(N, Dependencies),
    Queue = lists:foldl(fun(I, Acc) -> if InDegree(I) == 0 -> [I | Acc]; true -> Acc end end, [], lists:seq(1, N)),
    Courses = lists:seq(1, N),
    TopoSort = topological_sort(Graph, InDegree, Queue, []),
    reverse_topo(Courses, TopoSort).

reverse_topo([], _) -> [];
reverse_topo([H | T], L) ->
    case lists:member(H, L) of
        true -> [H | reverse_topo(T, lists:delete(H, L))];
        false -> reverse_topo(T, L)
    end.

topological_sort(_, _, [], Acc) -> Acc;
topological_sort(Graph, InDegree, [Node | Queue], Acc) ->
    NewAcc = [Node | Acc],
    lists:foreach(fun(Child) ->
        InDegree[Child] := InDegree[Child] - 1,
        if InDegree[Child] == 0 -> topological_sort(Graph, InDegree, [Child | Queue], NewAcc) end
    end, Graph[Node]),
    topological_sort(Graph, InDegree, Queue, NewAcc).

build_graph(N, Dependencies) ->
    Graph = lists:seq(1, N),
    lists:foldl(fun({From, To}, Acc) ->
        case maps:is_key(To, Acc) of
            true -> maps:update(To, [From | maps:get(To, Acc)], Acc);
            false -> maps:put(To, [From], Acc)
        end
    end, maps:from_list([{I, []} || I <- lists:seq(1, N)]), Dependencies).

build_indegree(N, Dependencies) ->
    InDegree = lists:seq(1, N),
    lists:foldl(fun({From, To}, Acc) ->
        maps:update(To, maps:get(To, Acc) + 1, Acc)
    end, maps:from_list([{I, 0} || I <- lists:seq(1, N)]), Dependencies).
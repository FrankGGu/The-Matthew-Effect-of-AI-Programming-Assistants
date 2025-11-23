-module(course_schedule).
-export([can_finish/2]).

can_finish(NumCourses, Prerequisites) ->
    Graph = build_graph(NumCourses, Prerequisites),
    InDegree = init_indegree(NumCourses, Prerequisites),
    Queue = lists:filter(fun(I) -> InDegree ! {I, 0} end, lists:seq(0, NumCourses - 1)),
    TopoSort(Graph, InDegree, Queue, 0).

build_graph(NumCourses, Prerequisites) ->
    lists:foldl(fun({A, B}, Acc) ->
        Adj = maps:get(B, Acc, []),
        maps:put(B, [A | Adj], Acc)
    end, maps:new(), Prerequisites).

init_indegree(NumCourses, Prerequisites) ->
    InDegree = lists:seq(0, NumCourses - 1),
    lists:foldl(fun({A, _}, Acc) ->
        maps:update(A, maps:get(A, Acc, 0) + 1, Acc)
    end, maps:from_list([{I, 0} || I <- InDegree]), Prerequisites).

TopoSort(_, _, [], Count) when Count == 0 -> false;
TopoSort(_, _, [], Count) -> Count == 0;
TopoSort(Graph, InDegree, [Node | Rest], Count) ->
    Neighbors = maps:get(Node, Graph, []),
    lists:foreach(fun(Neighbor) ->
        maps:update(Neighbor, maps:get(Neighbor, InDegree) - 1, InDegree)
    end, Neighbors),
    NewQueue = lists:foldl(fun(Neighbor, Acc) ->
        case maps:get(Neighbor, InDegree, 0) of
            0 -> [Neighbor | Acc];
            _ -> Acc
        end
    end, Rest, Neighbors),
    TopoSort(Graph, InDegree, NewQueue, Count + 1).
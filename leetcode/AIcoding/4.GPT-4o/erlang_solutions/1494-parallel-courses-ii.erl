-module(solution).
-export([minNumberOfSemesters/2]).

minNumberOfSemesters(N, Relations) ->
    Graph = build_graph(N, Relations),
    TopologicalSort = topological_sort(Graph, N),
    Semesters = array:new(N),
    lists:foldl(fun(Node, Acc) -> 
        Semester = max(1, lists:max(array:to_list(Acc, Node)) + 1),
        array:set(Node, Semester, Acc)
    end, Semesters, TopologicalSort).

build_graph(N, Relations) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun({X, Y}, Acc) -> 
        lists:update_at(X - 1, fun(L) -> [Y - 1 | L] end, Acc)
    end, Graph, Relations).

topological_sort(Graph, N) ->
    InDegrees = lists:duplicate(N, 0),
    lists:foldl(fun(Neighbors, Acc) ->
        lists:foldl(fun(Node, Acc2) -> lists:update_at(Node, fun(X) -> X + 1 end, Acc2) end, Acc, Neighbors)
    end, InDegrees, Graph),
    Queue = lists:filter(fun(X) -> X == 0 end, InDegrees),
    topological_sort_helper(Graph, Queue, []).

topological_sort_helper(_, [], Result) -> lists:reverse(Result);
topological_sort_helper(Graph, [Head | Tail], Result) ->
    NewResult = [Head | Result],
    NewQueue = lists:foldl(fun(Node, Acc) -> 
        NewInDegrees = lists:update_at(Node, fun(X) -> X - 1 end, InDegrees),
        case NewInDegrees of
            [0 | _] -> [Node | Acc];
            _ -> Acc
        end
    end, Tail, Graph),
    topological_sort_helper(Graph, NewQueue, NewResult).
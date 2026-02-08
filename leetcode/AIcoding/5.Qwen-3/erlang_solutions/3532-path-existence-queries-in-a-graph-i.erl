-module(path_existence_queries).
-export([checkIfPrerequisite/2]).

checkIfPrerequisite(NumCourses, Prerequisites) ->
    Graph = build_graph(NumCourses, Prerequisites),
    Pre = precompute_predecessors(Graph, NumCourses),
    fun(Query) -> check_query(Query, Pre) end.

build_graph(NumCourses, Prerequisites) ->
    lists:foldl(fun({A, B}, Acc) -> 
        maps:put(A, [B | maps:get(A, Acc, [])], Acc)
    end, maps:new(), Prerequisites).

precompute_predecessors(Graph, NumCourses) ->
    Pre = maps:new(),
    lists:foldl(fun(I, Acc) -> 
        maps:put(I, get_all_predecessors(I, Graph, maps:new()), Acc)
    end, Pre, lists:seq(0, NumCourses - 1)).

get_all_predecessors(Node, Graph, Visited) ->
    case maps:is_key(Node, Visited) of
        true -> maps:get(Node, Visited);
        false ->
            NewVisited = maps:put(Node, [], Visited),
            Preds = lists:foldl(fun(Child, Acc) ->
                ChildPreds = get_all_predecessors(Child, Graph, NewVisited),
                lists:umerge(Acc, ChildPreds)
            end, [], maps:get(Node, Graph, [])),
            maps:put(Node, lists:umerge(Preds, [Node]), NewVisited)
    end.

check_query({A, B}, Pre) ->
    lists:member(B, maps:get(A, Pre)).
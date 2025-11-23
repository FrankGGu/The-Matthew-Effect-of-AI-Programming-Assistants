-module(solution).
-export([find_order/2]).

find_order(NumCourses, Prerequisites) ->
    G = digraph:new(),
    lists:foreach(fun(I) -> digraph:add_vertex(G, I) end, lists:seq(0, NumCourses - 1)),
    lists:foreach(fun([V, U]) -> digraph:add_edge(G, U, V) end, Prerequisites),
    case topological_sort(G) of
        false -> [];
        Order -> Order
    end.

topological_sort(G) ->
    case digraph_utils:topsort(G) of
        false -> false;
        L -> L
    end.
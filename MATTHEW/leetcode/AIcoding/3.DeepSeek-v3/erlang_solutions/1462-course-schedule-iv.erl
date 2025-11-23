-module(solution).
-export([check_if_prerequisite/3]).

check_if_prerequisite(NumCourses, Prerequisites, Queries) ->
    G = digraph:new(),
    lists:foreach(fun(_) -> digraph:add_vertex(G) end, lists:seq(0, NumCourses - 1)),
    lists:foreach(fun([U, V]) -> digraph:add_edge(G, U, V) end, Prerequisites),
    lists:map(fun([U, V]) -> digraph:get_path(G, U, V) =/= false end, Queries).
-module(reachable_nodes_with_restrictions).
-export([reachable_nodes/2]).

reachable_nodes(Root, Restrictions) ->
    RestrictSet = sets:from_list(Restrictions),
    Graph = build_graph(Root),
    visited = sets:new(),
    dfs(Root, Graph, RestrictSet, visited).

build_graph([]) -> 
    #{}
;
build_graph([{Parent, Child} | Rest]) ->
    Graph = build_graph(Rest),
    ParentMap = maps:get(Parent, Graph, #{}),
    UpdatedParentMap = maps:put(Child, true, ParentMap),
    NewGraph = maps:put(Parent, UpdatedParentMap, Graph),
    ChildMap = maps:get(Child, Graph, #{}),
    UpdatedChildMap = maps:put(Parent, true, ChildMap),
    maps:put(Child, UpdatedChildMap, NewGraph).

dfs(Node, Graph, RestrictSet, Visited) ->
    if
        sets:is_element(Node, RestrictSet) -> 0;
        sets:is_element(Node, Visited) -> 0;
        true ->
            NewVisited = sets:add_element(Node, Visited),
            Children = maps:get(Node, Graph, #{}),
            Count = 1,
            lists:foldl(
                fun(Child, Acc) ->
                    Acc + dfs(Child, Graph, RestrictSet, NewVisited)
                end,
                Count,
                maps:keys(Children)
            )
    end.
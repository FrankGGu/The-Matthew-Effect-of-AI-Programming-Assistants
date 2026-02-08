-module(divide_nodes_into_max_groups).
-export([max_groups/1]).

max_groups(Graph) ->
    Nodes = lists:seq(0, length(Graph) - 1),
    Visited = sets:new(),
    Groups = [],
    dfs(Nodes, Graph, Visited, Groups).

dfs([], _, _, Groups) ->
    length(Groups);

dfs([Node | Rest], Graph, Visited, Groups) ->
    case sets:is_element(Node, Visited) of
        true ->
            dfs(Rest, Graph, Visited, Groups);
        false ->
            Group = [],
            {NewVisited, NewGroup} = build_group(Node, Graph, Visited, Group),
            dfs(Rest, Graph, NewVisited, [NewGroup | Groups])
    end.

build_group(Node, Graph, Visited, Group) ->
    case sets:is_element(Node, Visited) of
        true ->
            {Visited, Group};
        false ->
            NewVisited = sets:add_element(Node, Visited),
            Children = lists:nth(Node + 1, Graph),
            {NewVisited, NewGroup} = build_children(Children, Graph, NewVisited, Group),
            {NewVisited, [Node | NewGroup]}
    end.

build_children([], _, Visited, Group) ->
    {Visited, Group};

build_children([Child | Rest], Graph, Visited, Group) ->
    {NewVisited, NewGroup} = build_group(Child, Graph, Visited, Group),
    build_children(Rest, Graph, NewVisited, NewGroup).
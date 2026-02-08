-module(solution).
-export([create_binary_tree/1]).

create_binary_tree(Descriptions) ->
    Nodes = maps:new(),
    Parents = sets:new(),
    Children = sets:new(),
    {Nodes1, Parents1, Children1} = lists:foldl(
        fun([P, C, IsLeft], {N, PSet, CSet}) ->
            N1 = maps:put(P, {P, undefined, undefined}, N),
            N2 = maps:put(C, {C, undefined, undefined}, N1),
            PSet1 = sets:add_element(P, PSet),
            CSet1 = sets:add_element(C, CSet),
            {N2, PSet1, CSet1}
        end,
        {Nodes, Parents, Children},
        Descriptions
    ),
    Root = find_root(Parents1, Children1),
    lists:foldl(
        fun([P, C, IsLeft], N) ->
            {P, Left, Right} = maps:get(P, N),
            NewNode = case IsLeft of
                1 -> {P, C, Right};
                _ -> {P, Left, C}
            end,
            maps:put(P, NewNode, N)
        end,
        Nodes1,
        Descriptions
    ),
    build_tree(Root, Nodes1).

find_root(Parents, Children) ->
    ParentsList = sets:to_list(Parents),
    ChildrenList = sets:to_list(Children),
    [Root] = lists:subtract(ParentsList, ChildrenList),
    Root.

build_tree(Val, Nodes) ->
    case maps:find(Val, Nodes) of
        {ok, {_, undefined, undefined}} -> {Val, null, null};
        {ok, {_, Left, undefined}} -> {Val, build_tree(Left, Nodes), null};
        {ok, {_, undefined, Right}} -> {Val, null, build_tree(Right, Nodes)};
        {ok, {_, Left, Right}} -> {Val, build_tree(Left, Nodes), build_tree(Right, Nodes)};
        error -> null
    end.
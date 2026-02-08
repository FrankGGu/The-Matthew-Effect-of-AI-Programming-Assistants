-module(create_binary_tree).
-export([create_binary_tree/1]).

-spec create_binary_tree(Descriptions :: [[integer()]]) -> tree().
-type tree() :: {'nil'} | {integer(), tree(), tree()}.

create_binary_tree(Descriptions) ->
    RootNodes = find_root_nodes(Descriptions),
    Tree = build_tree(Descriptions, RootNodes),
    case RootNodes of
        [Root] ->
            maps:get(Root, Tree);
        [] ->
            'nil'
    end.

find_root_nodes(Descriptions) ->
    Children = lists:map(fun([_, Child, _]) -> Child end, Descriptions),
    Nodes = lists:usort(lists:map(fun([Parent, _, _]) -> Parent end, Descriptions)),
    lists:subtract(Nodes, Children).

build_tree(Descriptions, RootNodes) ->
    build_tree(Descriptions, RootNodes, #{}).

build_tree([], _, Tree) ->
    Tree;
build_tree(Descriptions, [Root|Rest], Tree) ->
    NewTree = build_tree_node(Root, Descriptions, Tree),
    build_tree(Descriptions, Rest, NewTree).

build_tree_node(Val, Descriptions, Tree) ->
    Children = find_children(Val, Descriptions),
    {Left, Right} = case Children of
        [] ->
            {'nil', 'nil'};
        [{L, 1}|[]] ->
            {case maps:is_key(L, Tree) of
                 true -> maps:get(L, Tree);
                 false -> build_tree_node(L, Descriptions, Tree)
             end, 'nil'};
        [{L, 1}, {R, 0}] ->
            {case maps:is_key(L, Tree) of
                 true -> maps:get(L, Tree);
                 false -> build_tree_node(L, Descriptions, Tree)
             end,
             case maps:is_key(R, Tree) of
                 true -> maps:get(R, Tree);
                 false -> build_tree_node(R, Descriptions, Tree)
             end};
        [{R, 0}|[]] ->
            {'nil',
             case maps:is_key(R, Tree) of
                 true -> maps:get(R, Tree);
                 false -> build_tree_node(R, Descriptions, Tree)
             end};
        [{R, 0}, {L, 1}] ->
            {case maps:is_key(L, Tree) of
                 true -> maps:get(L, Tree);
                 false -> build_tree_node(L, Descriptions, Tree)
             end,
             case maps:is_key(R, Tree) of
                 true -> maps:get(R, Tree);
                 false -> build_tree_node(R, Descriptions, Tree)
             end}
    end,
    maps:put(Val, {Val, Left, Right}, Tree).

find_children(Val, Descriptions) ->
    lists:usort([ {Child, IsLeft} || [Parent, Child, IsLeft] <- Descriptions, Parent == Val]).
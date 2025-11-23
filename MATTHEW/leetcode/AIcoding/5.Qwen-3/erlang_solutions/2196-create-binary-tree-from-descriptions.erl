-module(create_binary_tree_from_descriptions).
-export([createBinaryTree/1]).

createBinaryTree(Descriptions) ->
    {Nodes, _} = lists:foldl(fun({Parent, Child, IsLeft}, {Map, ParentMap}) ->
        NewMap = maps:put(Parent, [Child | maps:get(Parent, Map, [])], Map),
        NewParentMap = maps:put(Child, Parent, ParentMap),
        {NewMap, NewParentMap}
    end, {#{}, #{}}, Descriptions),
    Root = find_root(ParentMap),
    build_tree(Root, Nodes).

find_root(ParentMap) ->
    lists:foldl(fun(K, Acc) ->
        case maps:is_key(K, ParentMap) of
            true -> Acc;
            false -> K
        end
    end, nil, maps:keys(ParentMap)).

build_tree(nil, _) -> nil;
build_tree(Node, Nodes) ->
    Children = maps:get(Node, Nodes, []),
    Left = case lists:keyfind(true, 2, Children) of
        {_, Child, true} -> build_tree(Child, Nodes);
        false -> nil
    end,
    Right = case lists:keyfind(true, 2, lists:reverse(Children)) of
        {_, Child, true} -> build_tree(Child, Nodes);
        false -> nil
    end,
    {node, Node, Left, Right}.
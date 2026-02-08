-module(find_elements).
-export([new/1, find/2]).

-record(tree_node, {val, left, right}).

new(Root) ->
    fix_tree(Root, 0).

find(Val, {root, Root}) ->
    find_val(Root, Val).

fix_tree(null, _) ->
    null;
fix_tree({node, _, _, _} = Node, Val) ->
    LeftVal = 2 * Val + 1,
    RightVal = 2 * Val + 2,
    Left = fix_tree(element(2, Node), LeftVal),
    Right = fix_tree(element(3, Node), RightVal),
    {root, #tree_node{val = Val, left = Left, right = Right}}.

find_val(null, _) ->
    false;
find_val({root, #tree_node{val = Val}}, Val) ->
    true;
find_val({root, #tree_node{val = V, left = Left, right = Right}}, Val) ->
    find_val(Left, Val) orelse find_val(Right, Val).
-module(contaminated_binary_tree).
-export([new/1, find/2]).

-record(node, {val, left, right}).

new(Values) ->
    Root = build_tree(Values, 0),
    {Root, fun(Node) -> node_val(Node) end}.

build_tree([], _) -> nil;
build_tree([Val | Rest], Index) ->
    Left = build_tree(Rest, 2 * Index + 1),
    Right = build_tree(Rest, 2 * Index + 2),
    #node{val = Val, left = Left, right = Right}.

node_val(nil) -> undefined;
node_val(#node{val = Val}) -> Val.

find({Root, _}, Target) ->
    find_node(Root, Target).

find_node(nil, _) -> false;
find_node(#node{val = Val, left = Left, right = Right}, Target) ->
    if
        Val == Target -> true;
        true -> find_node(Left, Target) orelse find_node(Right, Target)
    end.
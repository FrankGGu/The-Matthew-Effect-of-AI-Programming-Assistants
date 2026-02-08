-module(solution).
-export([connect/1]).

-record(tree_node, {val, left, right, next}).

connect(undefined) ->
    undefined;
connect(Node) ->
    connect(Node, undefined).

connect(undefined, _) ->
    undefined;
connect(#tree_node{left = Left, right = Right} = Node, Next) ->
    Node#tree_node{next = Next},
    connect(Left, Right),
    connect(Right, NextRight(Node)),
    Node.

NextRight(#tree_node{right = Right}) ->
    case Right of
        undefined -> undefined;
        _ -> connect(Right, undefined)
    end.
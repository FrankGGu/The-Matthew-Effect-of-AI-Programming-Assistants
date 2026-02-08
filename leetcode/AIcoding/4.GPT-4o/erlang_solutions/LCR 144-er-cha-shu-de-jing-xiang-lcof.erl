-module(solution).
-export([invert_tree/1]).

-record(node, {val, left = null, right = null}).

invert_tree(null) -> null;
invert_tree(#node{left=Left, right=Right} = Node) ->
    Node#node{left = invert_tree(Right), right = invert_tree(Left)}.
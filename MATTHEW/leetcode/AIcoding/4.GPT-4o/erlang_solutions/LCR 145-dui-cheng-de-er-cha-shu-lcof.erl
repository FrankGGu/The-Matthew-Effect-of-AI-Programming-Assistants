-module(solution).
-export([is_symmetric/1]).

-record(tree, {val, left = none, right = none}).
none() -> undefined.

is_symmetric(Root) ->
    is_mirror(Root, Root).

is_mirror(Node1, Node2) ->
    case {Node1, Node2} of
        {none(), none()} -> true;
        {none(), _} -> false;
        {_, none()} -> false;
        {Node1Val, Node2Val} -> 
            Node1#tree.val == Node2#tree.val andalso 
            is_mirror(Node1#tree.left, Node2#tree.right) andalso 
            is_mirror(Node1#tree.right, Node2#tree.left)
    end.
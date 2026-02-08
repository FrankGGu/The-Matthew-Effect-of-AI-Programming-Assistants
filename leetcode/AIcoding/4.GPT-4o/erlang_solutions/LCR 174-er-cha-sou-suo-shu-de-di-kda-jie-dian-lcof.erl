-module(solution).
-export([search_bst/2]).

-record(node, {val, left = null, right = null}).

search_bst(Root, Target) ->
    case Root of
        null -> null;
        #node{val = Val} when Val =:= Target -> Root;
        #node{val = Val} when Val > Target -> search_bst(Root#node.left, Target);
        #node{val = Val} -> search_bst(Root#node.right, Target)
    end.
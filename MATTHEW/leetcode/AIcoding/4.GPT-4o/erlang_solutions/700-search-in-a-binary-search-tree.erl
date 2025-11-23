-module(solution).
-export([search_bst/2]).

-record(tree, {val, left = null, right = null}).

search_bst(Root, Val) ->
    case Root of
        null -> null;
        #tree{val = Val} -> Root;
        #tree{val = V} when Val < V -> search_bst(Root#tree.left, Val);
        #tree{val = V} -> search_bst(Root#tree.right, Val)
    end.
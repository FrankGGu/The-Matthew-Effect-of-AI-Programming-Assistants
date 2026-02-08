-module(n_ary_tree_preorder_traversal).
-export([preorder/1]).

-record(tree, {val, children = []}).

preorder(Root) when is_record(Root, tree) ->
    preorder_helper(Root, []).

preorder_helper(Root, Acc) ->
    case Root of
        #tree{val=Val, children=Children} ->
            NewAcc = [Val | Acc],
            lists:foldl(fun(Child, Acc) -> preorder_helper(Child, Acc) end, NewAcc, Children)
    end.
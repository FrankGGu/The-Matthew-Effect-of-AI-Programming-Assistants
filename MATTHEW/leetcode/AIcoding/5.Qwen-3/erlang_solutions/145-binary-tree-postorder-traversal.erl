-module(btree_postorder).
-export([postorder_traversal/1]).

-type tree() :: 'null' | {integer(), tree(), tree()}.

-spec postorder_traversal(tree()) -> [integer()].
postorder_traversal(Tree) ->
    postorder_traversal(Tree, []).

postorder_traversal('null', Acc) ->
    Acc;
postorder_traversal({Val, Left, Right}, Acc) ->
    postorder_traversal(Right, postorder_traversal(Left, [Val | Acc])).
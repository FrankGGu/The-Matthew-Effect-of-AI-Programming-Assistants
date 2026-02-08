-module(recover_binary_search_tree).
-export([recoverTree/1]).

-record(treeNode, {val, left, right}).

recoverTree(undefined) ->
    ok;
recoverTree(Tree) ->
    [A, B] = findSwappedNodes(Tree),
    swapValues(Tree, A, B).

findSwappedNodes(Tree) ->
    {_, Nodes} = inOrderTraverse(Tree, []),
    findSwapped(Nodes, []).

inOrderTraverse(undefined, Acc) ->
    {[], Acc};
inOrderTraverse(#treeNode{val=Val, left=Left, right=Right}, Acc) ->
    {L, Acc1} = inOrderTraverse(Left, Acc),
    {R, Acc2} = inOrderTraverse(Right, [Val | Acc1]),
    {R, Acc2}.

findSwapped([], Acc) ->
    lists:reverse(Acc);
findSwapped([H | T], [P | Acc]) when H > P ->
    findSwapped(T, [H | [P | Acc]]);
findSwapped([H | T], Acc) ->
    findSwapped(T, [H | Acc]).

swapValues(undefined, _, _) ->
    ok;
swapValues(#treeNode{val=A, left=Left, right=Right}, A, B) ->
    NewLeft = swapValues(Left, A, B),
    NewRight = swapValues(Right, A, B),
    #treeNode{val=B, left=NewLeft, right=NewRight};
swapValues(#treeNode{val=B, left=Left, right=Right}, A, B) ->
    NewLeft = swapValues(Left, A, B),
    NewRight = swapValues(Right, A, B),
    #treeNode{val=A, left=NewLeft, right=NewRight};
swapValues(#treeNode{val=V, left=Left, right=Right}, A, B) ->
    NewLeft = swapValues(Left, A, B),
    NewRight = swapValues(Right, A, B),
    #treeNode{val=V, left=NewLeft, right=NewRight}.
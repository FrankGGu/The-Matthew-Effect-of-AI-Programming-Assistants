-module(kth_largest_sum_in_binary_tree).

-export([kthLargestLevelSum/2]).

-spec kthLargestLevelSum(Root :: treeNode() | null, K :: integer()) -> integer().
kthLargestLevelSum(Root, K) ->
    Sums = levelSums(Root, []),
    SortedSums = lists:sort(descending, Sums),
    case lists:nth(K, SortedSums) of
        Sum -> Sum;
        _ -> -1
    end.

levelSums(null, Acc) ->
    Acc;
levelSums(Root, Acc) ->
    levelSumsHelper([Root], Acc).

levelSumsHelper([], Acc) ->
    lists:reverse(Acc);
levelSumsHelper(Nodes, Acc) ->
    Sum = sumOfNodes(Nodes),
    NextLevelNodes = nextLevelNodes(Nodes),
    levelSumsHelper(NextLevelNodes, [Sum | Acc]).

sumOfNodes(Nodes) ->
    lists:sum([nodeVal(Node) || Node <- Nodes]).

nodeVal(null) ->
    0;
nodeVal(Node) ->
    Node#treeNode.val.

nextLevelNodes(Nodes) ->
    lists:flatten([children(Node) || Node <- Nodes]).

children(null) ->
    [];
children(Node) ->
    [Node#treeNode.left, Node#treeNode.right] -- [null].

descending(A, B) ->
    A > B.

-record(treeNode, {val, left, right}).
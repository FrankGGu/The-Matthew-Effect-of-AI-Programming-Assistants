-module(solution).
-export([kth_largest_perfect_subtree_size/2]).

-record(node, {val, left = undefined, right = undefined}).

kth_largest_perfect_subtree_size(Root, K) ->
    SubtreeSizes = get_perfect_subtree_sizes(Root),
    lists:sort(fun(A, B) -> A > B end, SubtreeSizes),
    lists:nth(K, SubtreeSizes).

get_perfect_subtree_sizes(undefined) -> [];
get_perfect_subtree_sizes(Node) ->
    {LSize, RSize} = {get_perfect_subtree_size(Node#node.left), get_perfect_subtree_size(Node#node.right)},
    if
        LSize =:= RSize -> 
            [LSize + 1 | get_perfect_subtree_sizes(Node#node.left) ++ get_perfect_subtree_sizes(Node#node.right)];
        true -> 
            get_perfect_subtree_sizes(Node#node.left) ++ get_perfect_subtree_sizes(Node#node.right)
    end.

get_perfect_subtree_size(undefined) -> 0;
get_perfect_subtree_size(Node) ->
    1 + min(get_perfect_subtree_size(Node#node.left), get_perfect_subtree_size(Node#node.right)).
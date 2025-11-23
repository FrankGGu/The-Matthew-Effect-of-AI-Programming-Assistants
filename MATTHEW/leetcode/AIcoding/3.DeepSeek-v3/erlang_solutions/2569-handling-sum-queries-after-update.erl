-module(solution).
-export([handle_query/3]).

handle_query(Nums1, Nums2, Queries) ->
    {SegTree, N} = build_segment_tree(Nums1),
    handle_queries(SegTree, N, Nums2, Queries, []).

build_segment_tree(Nums) ->
    N = length(Nums),
    Size = 1 bsl (ceil_log2(N) + 1),
    SegTree = array:new(Size, {default, {0, 0, false}}),
    build_segment_tree(SegTree, Nums, 1, 0, N - 1).

build_segment_tree(SegTree, Nums, Node, L, R) when L =:= R ->
    Val = lists:nth(L + 1, Nums),
    array:set(Node, {Val, Val, false}, SegTree);
build_segment_tree(SegTree, Nums, Node, L, R) ->
    Mid = (L + R) div 2,
    LeftNode = 2 * Node,
    RightNode = 2 * Node + 1,
    SegTree1 = build_segment_tree(SegTree, Nums, LeftNode, L, Mid),
    SegTree2 = build_segment_tree(SegTree1, Nums, RightNode, Mid + 1, R),
    {LeftSum, LeftTotal, _} = array:get(LeftNode, SegTree2),
    {RightSum, RightTotal, _} = array:get(RightNode, SegTree2),
    array:set(Node, {LeftSum + RightSum, LeftTotal + RightTotal, false}, SegTree2).

ceil_log2(N) ->
    ceil_log2(N, 0).

ceil_log2(N, Res) when N =< 1 ->
    Res;
ceil_log2(N, Res) ->
    ceil_log2((N + 1) bsr 1, Res + 1).

handle_queries(_, _, Nums2, [], Acc) ->
    lists:reverse(Acc);
handle_queries(SegTree, N, Nums2, [Query | Rest], Acc) ->
    case Query of
        [1, L, R] ->
            NewSegTree = update_segment_tree(SegTree, 1, 0, N - 1, L, R),
            handle_queries(NewSegTree, N, Nums2, Rest, Acc);
        [2, P] ->
            Sum = query_segment_sum(SegTree, 1, 0, N - 1),
            NewNums2 = update_nums2(Nums2, P, Sum),
            handle_queries(SegTree, N, NewNums2, Rest, Acc);
        [3] ->
            Sum = lists:sum(Nums2),
            handle_queries(SegTree, N, Nums2, Rest, [Sum | Acc])
    end.

update_segment_tree(SegTree, Node, NodeL, NodeR, L, R) when NodeL > R orelse NodeR < L ->
    SegTree;
update_segment_tree(SegTree, Node, NodeL, NodeR, L, R) ->
    {Sum, Total, Flip} = array:get(Node, SegTree),
    if
        L =< NodeL andalso NodeR =< R ->
            NewSum = Total - Sum,
            array:set(Node, {NewSum, Total, not Flip}, SegTree);
        true ->
            Mid = (NodeL + NodeR) div 2,
            LeftNode = 2 * Node,
            RightNode = 2 * Node + 1,
            SegTree1 = propagate_flip(SegTree, Node, Sum, Total, Flip),
            SegTree2 = update_segment_tree(SegTree1, LeftNode, NodeL, Mid, L, R),
            SegTree3 = update_segment_tree(SegTree2, RightNode, Mid + 1, NodeR, L, R),
            {LeftSum, LeftTotal, _} = array:get(LeftNode, SegTree3),
            {RightSum, RightTotal, _} = array:get(RightNode, SegTree3),
            array:set(Node, {LeftSum + RightSum, LeftTotal + RightTotal, false}, SegTree3)
    end.

propagate_flip(SegTree, Node, Sum, Total, Flip) ->
    if
        not Flip -> SegTree;
        true ->
            LeftNode = 2 * Node,
            RightNode = 2 * Node + 1,
            {LeftSum, LeftTotal, LeftFlip} = array:get(LeftNode, SegTree),
            {RightSum, RightTotal, RightFlip} = array:get(RightNode, SegTree),
            SegTree1 = array:set(LeftNode, {LeftTotal - LeftSum, LeftTotal, not LeftFlip}, SegTree),
            array:set(RightNode, {RightTotal - RightSum, RightTotal, not RightFlip}, SegTree1)
    end.

query_segment_sum(SegTree, Node, NodeL, NodeR) ->
    {Sum, _, Flip} = array:get(Node, SegTree),
    if
        Flip -> (NodeR - NodeL + 1) - Sum;
        true -> Sum
    end.

update_nums2(Nums2, P, Sum) ->
    lists:map(fun(X) -> X + P * Sum end, Nums2).
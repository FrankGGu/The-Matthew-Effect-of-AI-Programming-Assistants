-module(majority_checker).

-export([init/1, query/2]).

-record(node, {left, right, left_idx, right_idx, majority, count}).

init(Arr) ->
    Tree = build_tree(Arr, 0, length(Arr) - 1),
    {ok, Tree}.

query({ok, Tree}, Left, Right, Threshold) ->
    {Majority, Count} = query_tree(Tree, Left, Right),
    case Count >= Threshold of
        true -> Majority;
        false -> -1
    end.

build_tree(Arr, LeftIdx, RightIdx) when LeftIdx == RightIdx ->
    #node{
        left = undefined,
        right = undefined,
        left_idx = LeftIdx,
        right_idx = RightIdx,
        majority = lists:nth(LeftIdx + 1, Arr),
        count = 1
    };
build_tree(Arr, LeftIdx, RightIdx) ->
    Mid = (LeftIdx + RightIdx) div 2,
    Left = build_tree(Arr, LeftIdx, Mid),
    Right = build_tree(Arr, Mid + 1, RightIdx),
    {Majority, Count} = merge_majority(Left, Right),
    #node{
        left = Left,
        right = Right,
        left_idx = LeftIdx,
        right_idx = RightIdx,
        majority = Majority,
        count = Count
    }.

merge_majority(Left, Right) ->
    LeftMajority = Left#node.majority,
    LeftCount = count_in_range(Left, Left#node.left_idx, Left#node.right_idx, LeftMajority) +
                count_in_range(Right, Left#node.left_idx, Left#node.right_idx, LeftMajority),
    RightMajority = Right#node.majority,
    RightCount = count_in_range(Left, Right#node.left_idx, Right#node.right_idx, RightMajority) +
                 count_in_range(Right, Right#node.left_idx, Right#node.right_idx, RightMajority),
    if
        LeftCount > RightCount -> {LeftMajority, LeftCount};
        true -> {RightMajority, RightCount}
    end.

count_in_range(Node, L, R, Val) ->
    if
        Node#node.right_idx < L; Node#node.left_idx > R -> 0;
        L =< Node#node.left_idx, Node#node.right_idx =< R ->
            if
                Node#node.majority == Val -> Node#node.count;
                true -> 0
            end;
        true ->
            count_in_range(Node#node.left, L, R, Val) + count_in_range(Node#node.right, L, R, Val)
    end.

query_tree(Node, L, R) ->
    if
        Node#node.right_idx < L; Node#node.left_idx > R -> {undefined, 0};
        L =< Node#node.left_idx, Node#node.right_idx =< R -> {Node#node.majority, Node#node.count};
        true ->
            {LeftMajority, LeftCount} = query_tree(Node#node.left, L, R),
            {RightMajority, RightCount} = query_tree(Node#node.right, L, R),
            if
                LeftMajority == RightMajority -> {LeftMajority, LeftCount + RightCount};
                LeftCount > RightCount -> {LeftMajority, LeftCount};
                true -> {RightMajority, RightCount}
            end
    end.
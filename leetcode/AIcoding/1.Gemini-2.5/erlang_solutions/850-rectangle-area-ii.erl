-module(solution).
-export([rectangleArea/1]).

rectangleArea(Rectangles) ->
    %% 1. Collect all unique x-coordinates and sort them
    XCoords = lists:sort(lists:usort([X || [X, _, _, _] <- Rectangles] ++ [X2 || [_, _, X2, _] <- Rectangles])),

    %% 2. Create events: {Y, X1_idx, X2_idx, Type}
    %% Type: 1 for start (add rectangle), -1 for end (remove rectangle)
    Events = lists:sort(
        fun({Y1, _, _, _}, {Y2, _, _, _}) when Y1 =/= Y2 -> Y1 < Y2;
           ({_, _, _, Type1}, {_, _, _, Type2}) -> Type1 > Type2 % Process start events before end events if Y is same
        end,
        lists:flatmap(
            fun([X1, Y1, X2, Y2]) ->
                X1Idx = find_x_index_list(X1, XCoords),
                X2Idx = find_x_index_list(X2, XCoords),
                [{Y1, X1Idx, X2Idx, 1}, {Y2, X1Idx, X2Idx, -1}]
            end,
            Rectangles
        )
    ),

    NumXSegments = length(XCoords) - 1, % Number of elementary intervals

    %% Initialize segment tree
    %% A segment tree with N leaves (NumXSegments) can be represented by an array of size ~4N.
    %% Node indices are 1-based for convenience in recursive calls (2*idx, 2*idx+1).
    %% array module is 0-indexed, so map NodeIdx to NodeIdx-1 for array access.
    TreeSize = 4 * NumXSegments,
    InitialTree = array:from_list([{0, 0} || _ <- lists:seq(1, TreeSize)]), % {count, covered_length}

    %% Start sweep line algorithm
    sweep_line(Events, XCoords, InitialTree, 0, 0, NumXSegments).

find_x_index_list(X, List) ->
    find_x_index_list(X, List, 0).

find_x_index_list(X, [H|_], Idx) when X == H -> Idx;
find_x_index_list(X, [_|T], Idx) -> find_x_index_list(X, T, Idx + 1).

sweep_line([], _XCoords, _CurrentTree, TotalArea, _PreviousY, _NumXSegments) ->
    TotalArea rem 1000000007;
sweep_line([{Y, X1Idx, X2Idx, Type} | RestEvents], XCoords, CurrentTree, TotalArea, PreviousY, NumXSegments) ->

    %% Calculate area for the strip between PreviousY and Y
    CurrentCoveredWidth = seg_tree_query(1, CurrentTree),
    StripArea = CurrentCoveredWidth * (Y - PreviousY),
    NewTotalArea = TotalArea + StripArea,

    %% Update segment tree with the current event
    UpdatedTree = seg_tree_update(1, 0, NumXSegments, X1Idx, X2Idx, Type, CurrentTree, XCoords),

    sweep_line(RestEvents, XCoords, UpdatedTree, NewTotalArea, Y, NumXSegments).

seg_tree_update(NodeIdx, NodeRangeStart, NodeRangeEnd, UpdateRangeStart, UpdateRangeEnd, Type, CurrentTree, XCoords) ->
    Node = array:get(NodeIdx - 1, CurrentTree),
    {Count, _CoveredLength} = Node,

    %% Case 1: Current node's range is completely outside the update range
    if UpdateRangeStart >= NodeRangeEnd; UpdateRangeEnd =< NodeRangeStart ->
        CurrentTree; % No change
    %% Case 2: Current node's range is fully contained within the update range
    true when UpdateRangeStart =< NodeRangeStart andalso UpdateRangeEnd >= NodeRangeEnd ->
        NewCount = Count + Type,
        NewNode = {NewCount, calculate_node_length(NodeIdx, NodeRangeStart, NodeRangeEnd, NewCount, CurrentTree, XCoords)},
        array:set(NodeIdx - 1, NewNode, CurrentTree);
    %% Case 3: Partial overlap, recurse on children
    true ->
        Mid = NodeRangeStart + (NodeRangeEnd - NodeRangeStart) div 2,
        LeftChildIdx = 2 * NodeIdx,
        RightChildIdx = 2 * NodeIdx + 1,

        TreeAfterLeftUpdate = seg_tree_update(LeftChildIdx, NodeRangeStart, Mid, UpdateRangeStart, UpdateRangeEnd, Type, CurrentTree, XCoords),
        TreeAfterRightUpdate = seg_tree_update(RightChildIdx, Mid, NodeRangeEnd, UpdateRangeStart, UpdateRangeEnd, Type, TreeAfterLeftUpdate, XCoords),

        %% After children are updated, recalculate current node's covered_length
        %% Its count remains `Count` (since it's an internal node, its count is only changed if fully covered).
        NewCoveredLength = calculate_node_length(NodeIdx, NodeRangeStart, NodeRangeEnd, Count, TreeAfterRightUpdate, XCoords),
        NewNode = {Count, NewCoveredLength},
        array:set(NodeIdx - 1, NewNode, TreeAfterRightUpdate)
    end.

calculate_node_length(NodeIdx, NodeRangeStart, NodeRangeEnd, CurrentNodeCount, CurrentTree, XCoords) ->
    if CurrentNodeCount > 0 ->
        %% If this node is covered by at least one rectangle, its entire range is covered.
        %% The length is XCoords[NodeRangeEnd] - XCoords[NodeRangeStart]
        lists:nth(NodeRangeEnd + 1, XCoords) - lists:nth(NodeRangeStart + 1, XCoords);
    true when NodeRangeStart + 1 == NodeRangeEnd -> % Leaf node covering a single elementary interval, and count is 0
        0;
    true -> % Internal node, count is 0, sum children's covered_length
        LeftChildIdx = 2 * NodeIdx,
        RightChildIdx = 2 * NodeIdx + 1,

        {_LC_Count, LC_CoveredLength} = array:get(LeftChildIdx - 1, CurrentTree),
        {_RC_Count, RC_CoveredLength} = array:get(RightChildIdx - 1, CurrentTree),

        LC_CoveredLength + RC_CoveredLength
    end.

seg_tree_query(NodeIdx, CurrentTree) ->
    {_Count, CoveredLength} = array:get(NodeIdx - 1, CurrentTree),
    CoveredLength.
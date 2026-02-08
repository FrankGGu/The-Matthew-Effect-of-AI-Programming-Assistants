-module(solution).
-export([solution/2]).

get_max({MaxHeight}) -> MaxHeight;
get_max({MaxHeight, _, _}) -> MaxHeight.

build_tree(HeightsArr, RangeL, RangeR) ->
    if
        RangeL == RangeR ->
            {element(RangeL + 1, HeightsArr)}; % Leaf node, +1 for 1-indexed tuple access
        true ->
            Mid = RangeL + (RangeR - RangeL) div 2,
            LeftTree = build_tree(HeightsArr, RangeL, Mid),
            RightTree = build_tree(HeightsArr, Mid + 1, RangeR),
            MaxVal = max(get_max(LeftTree), get_max(RightTree)),
            {MaxVal, LeftTree, RightTree}
    end.

find_first_greater(Tree, NodeRangeL, NodeRangeR, QueryRangeL, QueryRangeR, RequiredHeight) ->
    % 1. If the current node's range does not overlap with the query range, or
    %    if the maximum height in this node's range is not greater than RequiredHeight,
    %    then no valid building can be found in this branch.
    NodeMax = get_max(Tree),
    if
        NodeRangeL > QueryRangeR; NodeRangeR < QueryRangeL; NodeMax =< RequiredHeight ->
            -1;
        % 2. If this is a leaf node and its height is greater than RequiredHeight
        %    (already checked by NodeMax =< RequiredHeight condition),
        %    then this is the smallest index in its range meeting the criteria.
        NodeRangeL == NodeRangeR ->
            NodeRangeL;
        % 3. Otherwise, this is an internal node. Recursively search in children.
        true ->
            Mid = NodeRangeL + (NodeRangeR - NodeRangeL) div 2,
            {_, LeftTree, RightTree} = Tree,
            % Search in the left child first to find the smallest index.
            LeftResult = find_first_greater(LeftTree, NodeRangeL, Mid, QueryRangeL, QueryRangeR, RequiredHeight),
            if
                LeftResult =/= -1 ->
                    LeftResult; % Found in left child, so it's the smallest.
                true ->
                    % If not found in left, search in right child.
                    find_first_greater(RightTree, Mid + 1, NodeRangeR, QueryRangeL, QueryRangeR, RequiredHeight)
            end
    end.

solution(Heights, Queries) ->
    N = length(Heights),
    if
        N == 0 ->
            lists:map(fun(_) -> -1 end, Queries); % No buildings, all queries return -1
        true ->
            HeightsArr = list_to_tuple(Heights), % Convert list to tuple for O(1) access
            Tree = build_tree(HeightsArr, 0, N - 1), % Build the segment tree

            lists:map(fun({A, B}) ->
                              MinK = max(A, B),
                              RequiredHeight = max(element(A + 1, HeightsArr), element(B + 1, HeightsArr)),
                              find_first_greater(Tree, 0, N - 1, MinK, N - 1, RequiredHeight)
                      end, Queries)
    end.
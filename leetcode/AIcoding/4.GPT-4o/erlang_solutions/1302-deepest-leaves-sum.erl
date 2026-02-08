-module(solution).
-export([deepestLeavesSum/1]).

-record(node, {val, left = null, right = null}).

deepestLeavesSum(Root) ->
    {Sum, _} = deepestLeavesSumHelper(Root, 0, 0),
    Sum.

deepestLeavesSumHelper(null, Sum, _) -> {Sum, 0};
deepestLeavesSumHelper(Node, Sum, Depth) ->
    case Node of
        #node{left = null, right = null} ->
            if Depth > 0 -> {Sum + Node#node.val, Depth + 1};
            true -> {Node#node.val, Depth + 1}
            end;
        _ ->
            {LeftSum, LeftDepth} = deepestLeavesSumHelper(Node#node.left, Sum, Depth + 1),
            {RightSum, RightDepth} = deepestLeavesSumHelper(Node#node.right, Sum, Depth + 1),
            case {LeftDepth, RightDepth} of
                {L, R} when L > R -> {LeftSum, L};
                {L, R} when R > L -> {RightSum, R};
                _ -> {LeftSum + RightSum, LeftDepth}
            end
    end.
-module(solution).
-export([lowest_common_ancestor/3]).

-record(node, {val, left = none, right = none}).

lowest_common_ancestor(Root, P, Q) ->
    case Root of
        none -> none;
        _ ->
            Val = Root#node.val,
            PVal = P#node.val,
            QVal = Q#node.val,
            if
                PVal < Val, QVal < Val ->
                    lowest_common_ancestor(Root#node.left, P, Q);
                PVal > Val, QVal > Val ->
                    lowest_common_ancestor(Root#node.right, P, Q);
                true ->
                    Root
            end
    end.
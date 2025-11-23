-module(solution).
-export([lowest_common_ancestor/3]).

-record(node, {val, left = null, right = null}).

lowest_common_ancestor(Root, P, Q) ->
    case Root of
        null -> null;
        _ ->
            case (Root#node.val == P#node.val orelse Root#node.val == Q#node.val) of
                true -> Root;
                false ->
                    Left = lowest_common_ancestor(Root#node.left, P, Q),
                    Right = lowest_common_ancestor(Root#node.right, P, Q),
                    case {Left, Right} of
                        {null, null} -> null;
                        {null, _} -> Right;
                        {_, null} -> Left;
                        {_Left, _Right} -> Root
                    end
            end
    end.
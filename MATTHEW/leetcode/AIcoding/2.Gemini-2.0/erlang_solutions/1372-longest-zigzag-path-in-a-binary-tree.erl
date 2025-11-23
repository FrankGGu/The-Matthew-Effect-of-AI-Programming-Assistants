-module(longest_zigzag).
-export([longest_zigzag/1]).

longest_zigzag(Root) ->
    longest_zigzag_helper(Root, left, 0, 0, 0).

longest_zigzag_helper(null, _, Len, MaxLen, _) ->
    max(Len, MaxLen);
longest_zigzag_helper(TreeNode, Dir, Len, MaxLen, Depth) ->
    Val = maps:get(val, TreeNode),
    Left = maps:get(left, TreeNode, null),
    Right = maps:get(right, TreeNode, null),
    case Dir of
        left ->
            NewMaxLen = max(Len, MaxLen),
            NewMaxLen2 = longest_zigzag_helper(Right, right, 1, NewMaxLen, Depth + 1),
            NewMaxLen3 = longest_zigzag_helper(Left, left, 0, NewMaxLen2, Depth + 1),
            NewMaxLen3;
        right ->
            NewMaxLen = max(Len, MaxLen),
            NewMaxLen2 = longest_zigzag_helper(Left, left, 1, NewMaxLen, Depth + 1),
            NewMaxLen3 = longest_zigzag_helper(Right, right, 0, NewMaxLen2, Depth + 1),
            NewMaxLen3
    end.

max(A, B) ->
    if A > B -> A;
       true -> B
    end.
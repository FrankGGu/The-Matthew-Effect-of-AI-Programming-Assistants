-module(solution).
-export([pseudoPalindromicPaths/1]).

-record('TreeNode', {val, left, right}).

pseudoPalindromicPaths(Root) ->
    dfs(Root, 0).

dfs(null, _Mask) ->
    0;
dfs(#'TreeNode'{val = Val, left = Left, right = Right}, Mask) ->
    NewMask = Mask bxor (1 bsl Val),
    case {Left, Right} of
        {null, null} ->
            case (NewMask band (NewMask - 1)) == 0 of
                true -> 1;
                false -> 0
            end;
        _ ->
            dfs(Left, NewMask) + dfs(Right, NewMask)
    end.
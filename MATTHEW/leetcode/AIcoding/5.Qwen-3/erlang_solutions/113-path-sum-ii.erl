-module(path_sum_ii).
-export([pathSum/1]).

-record(TreeNode, {val, left, right}).

pathSum(undefined) -> [];
pathSum(#TreeNode{val=Val, left=Left, right=Right}) ->
    pathSum(Val, Left, Right, []).

pathSum(_, undefined, undefined, Path) ->
    [lists:reverse([Val | Path])];
pathSum(Val, Left, Right, Path) ->
    CurrentPath = [Val | Path],
    case Left of
        undefined ->
            case Right of
                undefined -> [lists:reverse(CurrentPath)];
                _ -> pathSum(Right#TreeNode.val, Right#TreeNode.left, Right#TreeNode.right, CurrentPath)
            end;
        _ ->
            case Right of
                undefined -> pathSum(Left#TreeNode.val, Left#TreeNode.left, Left#TreeNode.right, CurrentPath);
                _ ->
                    LeftPaths = pathSum(Left#TreeNode.val, Left#TreeNode.left, Left#TreeNode.right, CurrentPath),
                    RightPaths = pathSum(Right#TreeNode.val, Right#TreeNode.left, Right#TreeNode.right, CurrentPath),
                    LeftPaths ++ RightPaths
            end
    end.
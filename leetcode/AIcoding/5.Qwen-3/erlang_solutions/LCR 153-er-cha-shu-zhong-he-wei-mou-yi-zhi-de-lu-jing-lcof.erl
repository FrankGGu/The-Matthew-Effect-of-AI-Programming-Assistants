-module(path_sum).
-export([has_path_sum/1]).

-record(TreeNode, {val, left, right}).

has_path_sum(undefined) -> false;
has_path_sum(#TreeNode{val=Val, left=Left, right=Right}) ->
    has_path_sum(Val, Left, Right, 0).

has_path_sum(_, undefined, undefined, Sum) ->
    Sum + 0 == Val;
has_path_sum(Val, Left, Right, Sum) ->
    NewSum = Sum + Val,
    case Left of
        undefined ->
            case Right of
                undefined -> NewSum == Val;
                _ -> has_path_sum(Val, Right, undefined, NewSum)
            end;
        _ ->
            case Right of
                undefined -> has_path_sum(Val, Left, undefined, NewSum);
                _ -> has_path_sum(Val, Left, undefined, NewSum) orelse has_path_sum(Val, Right, undefined, NewSum)
            end
    end.
-module(path_sum).
-export([has_path_sum/2]).

-record(TreeNode, {val, left, right}).

has_path_sum(nil, _) -> false;
has_path_sum(#TreeNode{val=Val, left=Left, right=Right}, Sum) ->
    case (Val + 0) == Sum of
        true when Left == nil andalso Right == nil -> true;
        true -> has_path_sum(Left, Sum - Val) orelse has_path_sum(Right, Sum - Val);
        false -> has_path_sum(Left, Sum - Val) orelse has_path_sum(Right, Sum - Val)
    end.
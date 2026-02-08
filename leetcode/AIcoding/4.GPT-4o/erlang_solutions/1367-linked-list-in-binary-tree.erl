-module(solution).
-export([is_sub_path/2]).

-record(node, {val, left, right}).

is_sub_path(List, Tree) ->
    is_sub_path_helper(List, Tree).

is_sub_path_helper([], _) ->
    true;
is_sub_path_helper(_, nil) ->
    false;
is_sub_path_helper([H|T], Tree) ->
    case Tree#node.val == H of
        true -> 
            is_sub_path_helper(T, Tree#node.left) orelse is_sub_path_helper(T, Tree#node.right);
        false -> 
            false
    end.
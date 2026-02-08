-module(two_sum_iv).
-export([find_target/2]).

-record(TreeNode, {val, left, right}).

find_target(_, []) ->
    false;
find_target(Root, Target) ->
    Set = get_all_values(Root, sets:new()),
    lists:any(fun(X) -> sets:is_element(Target - X, Set) end, sets:to_list(Set)).

get_all_values(nil, Set) ->
    Set;
get_all_values(#TreeNode{val=Val, left=Left, right=Right}, Set) ->
    NewSet = sets:add_element(Val, Set),
    get_all_values(Left, NewSet),
    get_all_values(Right, NewSet).
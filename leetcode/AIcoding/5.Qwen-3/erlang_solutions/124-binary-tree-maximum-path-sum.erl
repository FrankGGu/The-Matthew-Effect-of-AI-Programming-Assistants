-module(btree_max_path_sum).
-export([max_path_sum/1]).

-record(tree, {val, left, right}).

max_path_sum(undefined) -> 0;
max_path_sum(Node) ->
    {Max, _} = helper(Node),
    Max.

helper(undefined) -> {0, 0};
helper(#tree{val=Val, left=Left, right=Right}) ->
    {LeftMax, LeftSingle} = helper(Left),
    {RightMax, RightSingle} = helper(Right),
    CurrentMax = max(Val + LeftSingle + RightSingle, Val + LeftSingle, Val + RightSingle, Val).
    CurrentSingle = max(Val + LeftSingle, Val + RightSingle, Val).
    MaxSoFar = max(CurrentMax, LeftMax, RightMax).
    {MaxSoFar, CurrentSingle}.
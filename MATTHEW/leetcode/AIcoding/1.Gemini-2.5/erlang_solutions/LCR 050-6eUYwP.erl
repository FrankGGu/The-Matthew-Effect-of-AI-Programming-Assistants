-module(solution).
-export([path_sum/2]).

-record(tree, {val=nil, left=nil, right=nil}).

path_sum(Root, TargetSum) ->
    dfs(Root, TargetSum, 0, #{0 => 1}).

dfs(nil, _TargetSum, _CurrentSum, _PrefixSumMap) ->
    0;
dfs(Node, TargetSum, CurrentSum, PrefixSumMap) ->
    NewCurrentSum = CurrentSum + Node#tree.val,
    Count = maps:get(NewCurrentSum - TargetSum, PrefixSumMap, 0),
    UpdatedPrefixSumMap = maps:update_with(NewCurrentSum, fun(V) -> V + 1 end, 1, PrefixSumMap),
    LeftCount = dfs(Node#tree.left, TargetSum, NewCurrentSum, UpdatedPrefixSumMap),
    RightCount = dfs(Node#tree.right, TargetSum, NewCurrentSum, UpdatedPrefixSumMap),
    Count + LeftCount + RightCount.
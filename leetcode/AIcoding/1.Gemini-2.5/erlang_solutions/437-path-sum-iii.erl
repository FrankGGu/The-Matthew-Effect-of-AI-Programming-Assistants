-module(solution).
-export([path_sum_iii/2]).

path_sum_iii(nil, _TargetSum) ->
    0;
path_sum_iii(#{val := Val, left := Left, right := Right}, TargetSum) ->
    CountFromCurrent = count_paths_from_node(#{val := Val, left := Left, right := Right}, TargetSum, 0),
    CountFromLeft = path_sum_iii(Left, TargetSum),
    CountFromRight = path_sum_iii(Right, TargetSum),
    CountFromCurrent + CountFromLeft + CountFromRight.

count_paths_from_node(nil, _TargetSum, _CurrentSum) ->
    0;
count_paths_from_node(#{val := Val, left := Left, right := Right}, TargetSum, CurrentSum) ->
    NewCurrentSum = CurrentSum + Val,
    Count = if NewCurrentSum == TargetSum -> 1;
              true -> 0
            end,
    Count
    + count_paths_from_node(Left, TargetSum, NewCurrentSum)
    + count_paths_from_node(Right, TargetSum, NewCurrentSum).
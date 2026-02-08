-module(solution).
-export([pathSum/2]).

pathSum(Root, TargetSum) ->
    path_sum_helper(Root, TargetSum, []).

path_sum_helper(nil, _, _CurrentPath) ->
    [];
path_sum_helper({Val, nil, nil}, TargetSum, CurrentPath) ->
    NewPath = [Val | CurrentPath],
    case Val == TargetSum of
        true ->
            [lists:reverse(NewPath)];
        false ->
            []
    end;
path_sum_helper({Val, Left, Right}, TargetSum, CurrentPath) ->
    NewTargetSum = TargetSum - Val,
    NewCurrentPath = [Val | CurrentPath],
    LeftResults = path_sum_helper(Left, NewTargetSum, NewCurrentPath),
    RightResults = path_sum_helper(Right, NewTargetSum, NewCurrentPath),
    LeftResults ++ RightResults.
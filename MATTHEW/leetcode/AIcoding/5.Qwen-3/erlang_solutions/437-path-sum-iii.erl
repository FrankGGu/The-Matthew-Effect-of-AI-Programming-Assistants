-module(path_sum_iii).
-export([path_sum/1]).

-include_lib("eunit/include/eunit.hrl").

-record(TreeNode, {val, left, right}).

path_sum(undefined) ->
    0;
path_sum(#TreeNode{val=Val, left=Left, right=Right}) ->
    count_paths(Val, Left, Right, Val) + path_sum(Left) + path_sum(Right).

count_paths(_, undefined, undefined, Target) ->
    0;
count_paths(Current, Left, Right, Target) ->
    Count = case Current of
        Target -> 1;
        _ -> 0
    end,
    Count + count_paths(Current + Val, Left, Right, Target) + count_paths(Current + Val, Right, Left, Target).

count_paths(_, undefined, _, _) ->
    0;
count_paths(_, _, undefined, _) ->
    0;
count_paths(Current, #TreeNode{val=Val}, #TreeNode{val=Val2}, Target) ->
    Count = case Current of
        Target -> 1;
        _ -> 0
    end,
    Count + count_paths(Current + Val, Left, Right, Target) + count_paths(Current + Val2, Left2, Right2, Target).
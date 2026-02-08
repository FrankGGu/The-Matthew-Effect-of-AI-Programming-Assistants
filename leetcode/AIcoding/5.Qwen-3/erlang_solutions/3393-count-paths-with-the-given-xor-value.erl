-module(solution).
-export([count_paths/2]).

count_paths(Root, Target) ->
    Count = 0,
    Map = #{0 => 1},
    dfs(Root, Target, 0, Map, Count).

dfs(nil, _, _, _, Count) ->
    Count;
dfs(#TreeNode{val = Val, left = Left, right = Right}, Target, Xor, Map, Count) ->
    NewXor = Xor bxor Val,
    CurrentCount = maps:get(NewXor, Map, 0),
    NewCount = Count + CurrentCount,
    NewMap = maps:put(NewXor, maps:get(NewXor, Map, 0) + 1, Map),
    LeftCount = dfs(Left, Target, NewXor, NewMap, NewCount),
    RightCount = dfs(Right, Target, NewXor, NewMap, LeftCount),
    maps:remove(NewXor, NewMap),
    RightCount.

-record(TreeNode, {val, left, right}).
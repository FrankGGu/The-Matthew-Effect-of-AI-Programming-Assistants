-module(solution).
-export([max_sum_subarray/1]).

max_sum_subarray(Nums) ->
    N = length(Nums),
    MaxSum = 0,
    Map = maps:new(),
    Left = 0,
    Right = 0,
    {MaxSum, _, _} = loop(Nums, N, MaxSum, Map, Left, Right),
    MaxSum.

loop(Nums, N, MaxSum, Map, Left, Right) when Right >= N ->
    {MaxSum, Map, Left};
loop(Nums, N, MaxSum, Map, Left, Right) ->
    Current = lists:nth(Right + 1, Nums),
    case maps:is_key(Current, Map) of
        true ->
            OldIndex = maps:get(Current, Map),
            NewMap = maps:remove(Current, Map),
            NewLeft = max(Left, OldIndex + 1),
            NewMap2 = maps:put(Current, Right, NewMap),
            NewSum = MaxSum + Current - lists:nth(NewLeft, Nums),
            loop(Nums, N, NewSum, NewMap2, NewLeft, Right + 1);
        false ->
            NewMap = maps:put(Current, Right, Map),
            NewSum = MaxSum + Current,
            loop(Nums, N, NewSum, NewMap, Left, Right + 1)
    end.
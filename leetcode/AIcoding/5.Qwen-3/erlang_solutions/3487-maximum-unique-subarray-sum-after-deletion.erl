-module(max_unique_subarray_sum_after_deletion).
-export([maximumUniqueSubarray/1]).

maximumUniqueSubarray(Arr) ->
    N = length(Arr),
    MaxSum = 0,
    Map = maps:new(),
    Left = 0,
    {MaxSum, _} = lists:foldl(fun(I, {CurrentSum, Map}) ->
        Val = lists:nth(I+1, Arr),
        case maps:is_key(Val, Map) of
            true ->
                OldLeft = maps:get(Val, Map),
                NewMap = maps:remove(Val, Map),
                NewMap2 = maps:fold(fun(K, V, Acc) ->
                    if V >= OldLeft -> maps:remove(K, Acc);
                       true -> Acc
                    end
                end, NewMap, NewMap),
                NewMap3 = maps:put(Val, I, NewMap2),
                CurrentSum2 = CurrentSum - lists:sum([lists:nth(J+1, Arr) || J <- lists:seq(Left, OldLeft-1)]),
                CurrentSum3 = CurrentSum2 + Val,
                {CurrentSum3, NewMap3};
            false ->
                CurrentSum2 = CurrentSum + Val,
                {CurrentSum2, maps:put(Val, I, Map)}
        end
    end, {0, Map}, lists:seq(0, N-1)),
    MaxSum.
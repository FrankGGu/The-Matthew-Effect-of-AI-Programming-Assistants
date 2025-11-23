-module(solution).
-export([smallest_divisor/2]).

smallest_divisor(Nums, Threshold) ->
    MaxNum = lists:max(Nums),
    binary_search(1, MaxNum, Nums, Threshold, MaxNum).

binary_search(Low, High, Nums, Threshold, CurrentBestAns) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    case check(Mid, Nums, Threshold) of
        true ->
            binary_search(Low, Mid - 1, Nums, Threshold, Mid);
        false ->
            binary_search(Mid + 1, High, Nums, Threshold, CurrentBestAns)
    end;
binary_search(_, _, _, _, CurrentBestAns) ->
    CurrentBestAns.

check(D, Nums, Threshold) ->
    Sum = lists:foldl(fun(Num, Acc) -> Acc + erlang:ceil(Num / D) end, 0, Nums),
    Sum =< Threshold.
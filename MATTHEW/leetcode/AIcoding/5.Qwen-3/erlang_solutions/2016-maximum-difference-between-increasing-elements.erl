-module(max_diff).
-export([maximumDifference/1]).

maximumDifference(Nums) ->
    maximumDifference(Nums, 1, 0).

maximumDifference([], _, MaxDiff) ->
    MaxDiff;
maximumDifference([H | T], Index, MaxDiff) ->
    CurrentMax = lists:max([H | T]),
    Diff = CurrentMax - H,
    NewMaxDiff = max(MaxDiff, Diff),
    maximumDifference(T, Index + 1, NewMaxDiff).
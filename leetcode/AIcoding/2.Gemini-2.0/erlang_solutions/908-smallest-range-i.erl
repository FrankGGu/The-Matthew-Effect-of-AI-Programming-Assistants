-module(smallest_range_i).
-export([smallestRangeI/2]).

smallestRangeI(Nums, K) ->
    Max = lists:max(Nums),
    Min = lists:min(Nums),
    Diff = Max - Min,
    if Diff > 2 * K ->
        Diff - 2 * K
    else
        0
    end.
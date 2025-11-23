-module(solution).
-export([findKthLargest/2]).

findKthLargest(Nums, K) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),
    lists:nth(Len - K + 1, SortedNums).
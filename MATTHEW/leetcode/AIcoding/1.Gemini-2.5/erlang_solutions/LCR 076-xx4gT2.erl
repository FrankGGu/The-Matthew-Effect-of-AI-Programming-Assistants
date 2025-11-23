-module(solution).
-export([findKthLargest/2]).

findKthLargest(Nums, K) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),
    Index = Len - K + 1,
    lists:nth(Index, SortedNums).
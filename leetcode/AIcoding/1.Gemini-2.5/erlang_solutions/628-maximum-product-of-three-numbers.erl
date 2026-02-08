-module(solution).
-export([maximum_product/1]).

maximum_product(Nums) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),

    P1 = lists:nth(Len - 2, SortedNums) * lists:nth(Len - 1, SortedNums) * lists:nth(Len, SortedNums),
    P2 = lists:nth(1, SortedNums) * lists:nth(2, SortedNums) * lists:nth(Len, SortedNums),

    max(P1, P2).
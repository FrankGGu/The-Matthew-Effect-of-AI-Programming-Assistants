-module(solution).
-export([min_moves2/1]).

-spec min_moves2([integer()]) -> integer().
min_moves2(Nums) ->
    Median = find_median(Nums),
    lists:sum(lists:map(fun(X) -> abs(X - Median) end, Nums)).

-spec find_median([integer()]) -> integer().
find_median(Nums) ->
    SortedNums = lists:sort(Nums),
    length(SortedNums) rem 2 =:= 1
    -> lists:nth(length(SortedNums) div 2 + 1, SortedNums);
    true
    -> lists:nth(length(SortedNums) div 2, SortedNums).

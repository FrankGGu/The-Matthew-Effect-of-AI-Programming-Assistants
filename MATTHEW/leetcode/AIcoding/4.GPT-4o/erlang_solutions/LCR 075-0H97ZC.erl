-module(solution).
-export([relative_sort_array/2]).

relative_sort_array/2 (arr1, arr2) ->
    SortedArr1 = lists:sort(arr1),
    RelativeSorted = lists:flatmap(fun(X) -> lists:filter(fun(Y) -> Y == X end, SortedArr1) end, arr2),
    Remaining = lists:filter(fun(X) -> not lists:member(X, arr2) end, SortedArr1),
    RemainingSorted = lists:sort(Remaining),
    RelativeSorted ++ RemainingSorted.
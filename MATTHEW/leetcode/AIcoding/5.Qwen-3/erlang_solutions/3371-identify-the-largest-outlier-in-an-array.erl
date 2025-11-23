-module(largest_outlier).
-export([largest_outlier/1]).

largest_outlier(Nums) ->
    Sorted = lists:sort(Nums),
    Sum = lists:sum(Sorted),
    Max = hd(lists:reverse(Sorted)),
    FindLargestOutlier(Sorted, Sum, Max).

FindLargestOutlier([H | T], Sum, Max) ->
    if
        (Sum - H) == H ->
            H;
        true ->
            FindLargestOutlier(T, Sum, Max)
    end;
FindLargestOutlier([], _, _) ->
    0.
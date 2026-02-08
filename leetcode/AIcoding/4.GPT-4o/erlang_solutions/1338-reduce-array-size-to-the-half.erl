-module(solution).
-export([min_set_size/1]).

min_set_size(Array) ->
    Counts = lists:foldl(fun(X, Acc) ->
        maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc)
    end, maps:new(), Array),
    SortedCounts = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(Counts)),
    Total = length(Array),
    MinSize = Total div 2,
    min_set_size(SortedCounts, MinSize, 0, 0).

min_set_size([], _, _, Count) ->
    Count;
min_set_size([{_, C} | T], MinSize, Acc, Count) ->
    if
        Acc + C >= MinSize ->
            Count + 1;
        true ->
            min_set_size(T, MinSize, Acc + C, Count + 1)
    end.
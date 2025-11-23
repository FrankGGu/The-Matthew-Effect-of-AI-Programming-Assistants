-module(solution).
-export([most_frequent_ids/2]).

most_frequent_ids(Ids, k) ->
    IdsCount = lists:foldl(fun(Id, Acc) ->
        maps:update_with(Id, fun(X) -> X + 1 end, 1, Acc)
    end, maps:new(), Ids),
    SortedIds = maps:to_list(IdsCount),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B orelse (A =:= B andalso element(1, {_, A}) < element(1, {_, B})) end, SortedIds),
    lists:sublist([Id || {Id, _} <- Sorted], k).
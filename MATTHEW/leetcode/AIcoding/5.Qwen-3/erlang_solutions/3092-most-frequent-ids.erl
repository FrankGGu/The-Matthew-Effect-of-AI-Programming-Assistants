-module(most_frequent_ids).
-export([mostFrequentIDs/1]).

mostFrequentIDs(Ids) ->
    Count = lists:foldl(fun(Id, Acc) -> 
        maps:update_with(Id, fun(V) -> V + 1 end, 1, Acc) 
    end, #{}, Ids),
    Sorted = lists:sort(fun({_, A}, {_, B}) -> A > B end, maps:to_list(Count)),
    [Id || {Id, _} <- Sorted].
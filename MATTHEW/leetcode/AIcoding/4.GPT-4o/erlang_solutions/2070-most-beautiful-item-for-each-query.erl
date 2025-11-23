-module(solution).
-export([most_beautiful_item/2]).

most_beautiful_item(Items, Queries) ->
    SortedItems = lists:sort(fun({V1, _}, {V2, _}) -> V1 > V2 end, Items),
    lists:map(fun(Q) -> find_most_beautiful(Q, SortedItems) end, Queries).

find_most_beautiful(Q, SortedItems) ->
    case lists:filter(fun({_, W}) -> W <= Q end, SortedItems) of
        [] -> -1;
        Items -> hd(Items)
    end.
-module(merge_similar_items).
-export([merge similar items/1]).

merge_similar_items(Items) ->
    Map = lists:foldl(fun({Id, Value}, Acc) ->
        case maps:find(Id, Acc) of
            {ok, V} -> maps:put(Id, V + Value, Acc);
            error -> maps:put(Id, Value, Acc)
        end
    end, #{}, Items),
    lists:sort([{Id, Value} || {Id, Value} <- maps:to_list(Map)]).
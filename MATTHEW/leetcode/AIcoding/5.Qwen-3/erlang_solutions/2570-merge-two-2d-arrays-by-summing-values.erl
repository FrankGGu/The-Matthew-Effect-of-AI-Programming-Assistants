-module(merge_two_2d_arrays_by_summing_values).
-export([merge_similar_items/1]).

merge_similar_items(Items) ->
    Maps = lists:foldl(fun({Key, Value}, Acc) ->
        maps:update_with(Key, fun(V) -> V + Value end, Value, Acc)
    end, #{}, Items),
    maps:to_list(Maps).
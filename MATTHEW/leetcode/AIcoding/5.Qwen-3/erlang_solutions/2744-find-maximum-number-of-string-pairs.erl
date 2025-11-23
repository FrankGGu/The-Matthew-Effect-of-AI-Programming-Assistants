-module(solution).
-export([maximum_number_of_pairs/1]).

maximum_number_of_pairs(Strings) ->
    Map = lists:foldl(fun(Str, Acc) -> 
        Key = lists:sort(Str),
        maps:update_with(Key, fun(V) -> V + 1 end, 1, Acc)
    end, maps:new(), Strings),
    lists:foldl(fun({_Key, Count}, Acc) -> 
        Acc + (Count div 2)
    end, 0, maps:to_list(Map)).
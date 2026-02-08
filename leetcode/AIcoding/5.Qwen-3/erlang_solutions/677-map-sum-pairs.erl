-module(map_sum_pairs).
-export([map_sum/1]).

map_sum(Operations) ->
    map_sum(Operations, dict:new(), 0).

map_sum([], _, Result) ->
    Result;
map_sum([{"insert", Key, Value} | Rest], Dict, _) ->
    map_sum(Rest, dict:store(Key, Value, Dict), 0);
map_sum([{"sum", Prefix} | Rest], Dict, Result) ->
    Keys = dict:keys(Dict),
    Sum = lists:foldl(fun(Key, Acc) ->
        case string:prefix(Key, Prefix) of
            true -> Acc + dict:fetch(Key, Dict);
            _ -> Acc
        end
    end, 0, Keys),
    map_sum(Rest, Dict, Result + Sum);
map_sum(_, _, Result) ->
    Result.
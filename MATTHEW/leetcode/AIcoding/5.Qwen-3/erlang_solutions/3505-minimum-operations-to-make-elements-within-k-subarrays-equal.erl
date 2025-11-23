-module(min_ops).
-export([min_operations/2]).

min_operations(List, K) ->
    N = length(List),
    Map = maps:new(),
    lists:foldl(fun(I, Acc) ->
        case I + K - 1 =< N of
            true ->
                Sub = lists:sublist(List, I, K),
                Count = maps:get(Sub, Acc, 0),
                maps:put(Sub, Count + 1, Acc);
            false ->
                Acc
        end
    end, Map, lists:seq(1, N - K + 1)).

min_ops(Map) ->
    lists:foldl(fun(_Key, Value, Acc) ->
        if Value > Acc -> Value;
           true -> Acc
        end
    end, 0, Map).

min_operations(List, K) ->
    Map = min_operations(List, K),
    MinCount = min_ops(Map),
    length(List) - MinCount.
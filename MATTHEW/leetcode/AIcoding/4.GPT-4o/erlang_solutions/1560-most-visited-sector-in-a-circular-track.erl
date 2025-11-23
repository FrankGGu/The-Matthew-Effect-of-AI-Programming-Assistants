-module(solution).
-export([most_visited/2]).

most_visited(N, rounds) ->
    Counts = lists:foldl(fun(X, Acc) ->
        case X of
            [] -> Acc;
            [Start, End] ->
                lists:foldl(fun(I, Acc1) -> 
                    lists:update_counter(I, 1, Acc1)
                end, Acc, lists:seq(Start, End))
        end
    end, lists:duplicate(N, 0), rounds),
    MaxCount = lists:max(Counts),
    lists:foldl(fun({Index, Count}, Acc) ->
        if Count =:= MaxCount -> [Index + 1 | Acc];
           true -> Acc
        end
    end, [], lists:with_index(Counts)).

update_counter(Key, Value, Map) ->
    case lists:keyfind(Key, 1, Map) of
        false -> [{Key, Value} | Map];
        {Key, OldValue} -> [{Key, OldValue + Value} | lists:keydelete(Key, 1, Map)]
    end.

with_index(List) ->
    lists:foldl(fun(X, {Index, Acc}) -> {Index + 1, [{Index, X} | Acc]} end, {1, []}, List) |> elem(1).
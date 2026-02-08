-module(partition_array).
-export([max_diff/2]).

max_diff(List, K) ->
    Sorted = lists:sort(List),
    Partition = partition(Sorted, K, []),
    lists:reverse(Partition).

partition([], _, Acc) ->
    Acc;
partition([H|T], K, Acc) ->
    case Acc of
        [] ->
            partition(T, K, [[H]]);
        [Current | Rest] ->
            case (lists:last(Current) - H) =< K of
                true ->
                    partition(T, K, [[H | Current] | Rest]);
                false ->
                    partition(T, K, [[H] | Acc])
            end
    end.
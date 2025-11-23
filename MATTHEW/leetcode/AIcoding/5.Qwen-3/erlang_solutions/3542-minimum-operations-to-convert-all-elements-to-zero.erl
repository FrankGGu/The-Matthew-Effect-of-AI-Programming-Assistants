-module(min_operations).
-export([minOperations/1]).

minOperations(Nums) ->
    minOperations(Nums, 0).

minOperations([], _) ->
    0;
minOperations([H | T], Acc) ->
    case H of
        0 -> minOperations(T, Acc);
        _ -> minOperations(T, Acc + H)
    end.
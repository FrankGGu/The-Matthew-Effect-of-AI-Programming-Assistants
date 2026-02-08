-module(minimum_operations_to_exceed_threshold_value_i).
-export([min_operations/2]).

min_operations(Numbers, Threshold) ->
    min_operations(Numbers, Threshold, 0, 0).

min_operations([], _, _, Acc) ->
    Acc;
min_operations([H | T], Threshold, Count, Acc) ->
    NewAcc = Acc + H,
    if
        NewAcc >= Threshold ->
            Count + 1;
        true ->
            min_operations(T, Threshold, Count + 1, NewAcc)
    end.
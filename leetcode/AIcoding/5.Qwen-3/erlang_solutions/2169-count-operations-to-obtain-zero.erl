-module(count_operations_to_obtain_zero).
-export([count_ops/2]).

count_ops(A, B) ->
    count_ops(A, B, 0).

count_ops(0, _, Acc) ->
    Acc;
count_ops(_, 0, Acc) ->
    Acc;
count_ops(A, B, Acc) ->
    if
        A >= B ->
            count_ops(A - B, B, Acc + 1);
        true ->
            count_ops(A, B - A, Acc + 1)
    end.
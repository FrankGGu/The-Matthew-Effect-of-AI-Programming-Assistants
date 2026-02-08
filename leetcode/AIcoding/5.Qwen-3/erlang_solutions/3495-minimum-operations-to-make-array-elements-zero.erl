-module(min_operations).
-export([min_operations/1]).

min_operations(A) ->
    min_operations(A, 0).

min_operations([], _) ->
    0;
min_operations([H | T], Acc) ->
    case H of
        0 ->
            min_operations(T, Acc);
        _ ->
            min_operations(T, Acc + 1)
    end.
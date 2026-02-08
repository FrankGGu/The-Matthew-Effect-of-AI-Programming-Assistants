-module(solution).
-export([max_operations/1]).

max_operations(Nums) ->
    max_operations(Nums, 0, 0).

max_operations([], _, Acc) ->
    Acc;
max_operations([A, B | T], Count, Acc) ->
    if
        A + B == 1 ->
            max_operations(T, Count + 1, Acc + 1);
        true ->
            max_operations([B | T], Count, Acc)
    end;
max_operations([_], _, Acc) ->
    Acc.
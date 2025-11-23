-module(solution).
-export([min_operations/1]).

min_operations([]) -> 0;
min_operations([H|T]) ->
    min_operations_acc(T, H, 0).

min_operations_acc([], _Prev, AccOps) ->
    AccOps;
min_operations_acc([H|T], Prev, AccOps) ->
    if
        H > Prev ->
            min_operations_acc(T, H, AccOps);
        true ->
            NewH = Prev + 1,
            Ops = NewH - H,
            min_operations_acc(T, NewH, AccOps + Ops)
    end.
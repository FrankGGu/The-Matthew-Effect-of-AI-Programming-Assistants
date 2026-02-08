-module(solution).
-export([min_operations/1]).

min_operations(Array) ->
    Sorted = lists:sort(Array),
    min_ops(Sorted, 0, -1).

min_ops([], Ops, _) -> Ops;
min_ops([H | T], Ops, Last) ->
    NewLast = max(H, Last + 1),
    min_ops(T, Ops + (NewLast - H), NewLast).
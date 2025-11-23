-module(solution).
-export([min_operations/1]).

min_operations([Nums, Target]) ->
    min_operations(Nums, Target).

min_operations(Nums, Target) ->
    Sum = lists:sum(Nums),
    if
        Sum < Target -> -1;
        true ->
            Operations = 0,
            Sorted = lists:sort(fun(A, B) -> A =< B end, Nums),
            min_operations_helper(Sorted, Target, Operations)
    end.

min_operations_helper([], 0, Operations) -> Operations;
min_operations_helper([], _, _) -> -1;
min_operations_helper([H | T], Target, Operations) ->
    if
        H > Target ->
            case T of
                [] -> -1;
                [Next | Rest] ->
                    NewNum = Next * 2,
                    min_operations_helper([NewNum | Rest], Target, Operations + 1)
            end;
        true ->
            min_operations_helper(T, Target - H, Operations)
    end.
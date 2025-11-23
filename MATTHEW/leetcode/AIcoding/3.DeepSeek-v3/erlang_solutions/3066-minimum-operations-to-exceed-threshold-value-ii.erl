-module(min_operations).

-export([min_operations/2]).

min_operations(Nums, K) ->
    case lists:all(fun(X) -> X >= K end, Nums) of
        true -> 0;
        false ->
            Sorted = lists:sort(Nums),
            min_operations_helper(Sorted, K, 0)
    end.

min_operations_helper([X, Y | Rest], K, Count) when X < K orelse Y < K ->
    NewNum = X + 2 * Y,
    NewList = insert_sorted(NewNum, Rest),
    min_operations_helper(NewList, K, Count + 1);
min_operations_helper(_, _, Count) ->
    Count.

insert_sorted(X, []) -> [X];
insert_sorted(X, [H | T]) when X =< H -> [X, H | T];
insert_sorted(X, [H | T]) -> [H | insert_sorted(X, T)].
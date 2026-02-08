-module(solution).
-export([min_operations/2]).

min_operations(Nums, K) ->
    min_operations(Nums, K, 0).

min_operations([], _, Count) ->
    Count;
min_operations([H|T], K, Count) ->
    if
        H < K ->
            min_operations(T, K, Count + 1);
        true ->
            min_operations(T, K, Count)
    end.
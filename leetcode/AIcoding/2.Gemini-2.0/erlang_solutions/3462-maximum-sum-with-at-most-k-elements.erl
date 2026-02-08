-module(max_sum_k_elements).
-export([maximum_sum/2]).

maximum_sum(Nums, K) ->
    lists:foldl(fun(N, Acc) ->
                        insert_sorted(N, Acc)
                end, [], Nums)
    |> lists:reverse()
    |> lists:sublist(1, K)
    |> lists:sum().

insert_sorted(X, []) ->
    [X];
insert_sorted(X, [H|T]) when X >= H ->
    [X,H|T];
insert_sorted(X, [H|T]) ->
    [H|insert_sorted(X, T)].
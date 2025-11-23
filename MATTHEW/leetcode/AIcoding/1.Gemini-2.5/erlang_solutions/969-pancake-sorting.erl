-module(solution).
-export([pancake_sort/1]).

pancake_sort(A) ->
    N = length(A),
    lists:reverse(pancake_sort_recursive(A, N, [])).

pancake_sort_recursive(_List, 1, AccFlips) ->
    AccFlips;
pancake_sort_recursive(List, N, AccFlips) ->
    Index = find_index(List, N),
    if
        Index == N - 1 ->
            pancake_sort_recursive(List, N - 1, AccFlips);
        true ->
            K1 = Index + 1,
            List1 = list_reverse_first_k(List, K1),

            K2 = N,
            List2 = list_reverse_first_k(List1, K2),

            pancake_sort_recursive(List2, N - 1, [K2, K1 | AccFlips])
    end.

find_index(List, Value) ->
    find_index_acc(List, Value, 0).

find_index_acc([H|_], Value, Index) when H == Value ->
    Index;
find_index_acc([_|T], Value, Index) ->
    find_index_acc(T, Value, Index + 1).

list_reverse_first_k(List, K) ->
    {Head, Tail} = split_at(List, K),
    lists:reverse(Head) ++ Tail.

split_at(List, K) ->
    split_at_acc(List, K, []).

split_at_acc([H|T], K, AccHead) when K > 0 ->
    split_at_acc(T, K - 1, [H|AccHead]);
split_at_acc(List, 0, AccHead) ->
    {lists:reverse(AccHead), List}.
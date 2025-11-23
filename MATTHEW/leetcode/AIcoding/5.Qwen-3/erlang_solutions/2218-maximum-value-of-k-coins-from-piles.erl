-module(solution).
-export([max_value_of_k_coins/2]).

max_value_of_k_coins(Piles, K) ->
    max_value_of_k_coins(Piles, K, 0, 0, []).

max_value_of_k_coins([], _, _, _, Acc) ->
    lists:reverse(Acc);
max_value_of_k_coins([Pile | Piles], K, Count, Sum, Acc) ->
    Sorted = lists:reverse(lists:sort(Pile)),
    Take = min(K - Count, length(Sorted)),
    NewSum = Sum + lists:sum(lists:sublist(Sorted, Take)),
    NewCount = Count + Take,
    max_value_of_k_coins(Piles, K, NewCount, NewSum, [NewSum | Acc]).

max_value_of_k_coins(_, _, _, _, Acc) when length(Acc) == 0 ->
    0;
max_value_of_k_coins(_, _, _, _, Acc) ->
    lists:foldl(fun(X, Acc2) -> max(X, Acc2) end, 0, Acc).
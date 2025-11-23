-module(solution).
-export([max_items/2]).

max_items(Prices, K) ->
    SortedPrices = lists:sort(Prices),
    max_items_recursive(SortedPrices, K, 0, 0).

max_items_recursive([], _K, Count, _CurrentSum) ->
    Count;
max_items_recursive([Price | Rest], K, Count, CurrentSum) ->
    NewSum = CurrentSum + Price,
    if
        NewSum =< K ->
            max_items_recursive(Rest, K, Count + 1, NewSum);
        true ->
            Count
    end.
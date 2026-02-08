-module(max_elegance).
-export([find_max_elegance/2]).

find_max_elegance(Prices, K) ->
    lists:reverse(lists:sort([{Price, Category} || {Price, Category} <- lists:zip(Prices, lists:seq(1, length(Prices))) ])),
    Sorted = lists:sort(Prices),
    Categories = lists:usort([Category || {_, Category} <- lists:zip(Prices, lists:seq(1, length(Prices)))]),
    MaxElegance = 0,
    find_max_elegance(Sorted, Categories, K, MaxElegance).

find_max_elegance(_, _, 0, Elegance) ->
    Elegance;
find_max_elegance([], _, _, _) ->
    0;
find_max_elegance([Price | Rest], Categories, K, Elegance) ->
    NewElegance = case lists:member(Price, Categories) of
        true -> Elegance + 1;
        false -> Elegance
    end,
    find_max_elegance(Rest, Categories, K - 1, NewElegance).
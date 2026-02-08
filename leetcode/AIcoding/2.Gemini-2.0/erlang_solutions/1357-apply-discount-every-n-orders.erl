-module(discount).
-export([start/2, getBill/3]).

start(Product, Discount) ->
    ets:new(orders, [named_table, public, set]),
    ets:insert(orders, {count, 0}),
    {ok, {Product, Discount}}.

getBill({Product, Discount}, Products, Quantity) ->
    [{P, Q} || {P, Q} <- lists:zip(Products, Quantity)],
    {Count} = ets:lookup(orders, count),
    ets:insert(orders, {count, Count + 1}),
    NewCount = Count + 1,
    Total = lists:sum([lookup(P, Product) * Q || {P, Q} <- lists:zip(Products, Quantity)]),
    case NewCount rem length(Product) of
        0 ->
            Total * (1 - Discount / 100);
        _ ->
            Total
    end.

lookup(Key, Dict) ->
    case lists:keyfind(Key, 1, Dict) of
        false ->
            0;
        {Key, Value} ->
            Value
    end.
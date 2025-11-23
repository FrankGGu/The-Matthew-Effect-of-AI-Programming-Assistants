-module(sales_inventory_iii).
-export([num_shipments/1]).

num_shipments(Ships) ->
    num_shipments(Ships, 0).

num_shipments([], Count) ->
    Count;
num_shipments([H | T], Count) ->
    if
        H == 0 ->
            num_shipments(T, Count + 1);
        true ->
            num_shipments(T, Count)
    end.
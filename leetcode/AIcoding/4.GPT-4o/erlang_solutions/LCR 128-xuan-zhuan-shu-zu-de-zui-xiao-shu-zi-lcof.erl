-module(inventory_management).
-export([checkInventory/2]).

checkInventory(Inventory, Threshold) ->
    lists:filter(fun({_, Quantity}) -> Quantity >= Threshold end, Inventory).
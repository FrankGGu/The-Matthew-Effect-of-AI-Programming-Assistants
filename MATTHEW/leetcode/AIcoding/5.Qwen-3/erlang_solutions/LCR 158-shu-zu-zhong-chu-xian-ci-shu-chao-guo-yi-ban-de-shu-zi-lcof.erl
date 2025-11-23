-module(sales_inventory_ii).
-export([stock_management/1]).

stock_management(Stock) ->
    lists:foldl(fun(Item, Acc) -> 
        case lists:keyfind(Item, 1, Acc) of
            false -> [{Item, 1} | Acc];
            {Item, Count} -> lists:keyreplace(Item, 1, Acc, {Item, Count + 1})
        end
    end, [], Stock).

stock_management(_Args) ->
    ok.
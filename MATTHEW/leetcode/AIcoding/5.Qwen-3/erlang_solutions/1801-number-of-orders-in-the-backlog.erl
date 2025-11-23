-module(backlog).
-export([number_of_orders_in_the_backlog/1]).

number_of_orders_in_the_backlog(Orders) ->
    {Buy, Sell} = lists:foldl(fun(Order, {Buy, Sell}) ->
        [Price, Amount, _Type] = Order,
        case _Type of
            0 -> {add_to_buy(Buy, Price, Amount), Sell};
            1 -> {Buy, add_to_sell(Sell, Price, Amount)}
        end
    end, {gb_trees:empty(), gb_trees:empty()}, Orders),
    sum_amounts(Buy) + sum_amounts(Sell).

add_to_buy(Buy, Price, Amount) ->
    case gb_trees:lookup(Price, Buy) of
        none -> gb_trees:insert(Price, Amount, Buy);
        {value, Existing} -> gb_trees:insert(Price, Existing + Amount, Buy)
    end.

add_to_sell(Sell, Price, Amount) ->
    case gb_trees:lookup(Price, Sell) of
        none -> gb_trees:insert(Price, Amount, Sell);
        {value, Existing} -> gb_trees:insert(Price, Existing + Amount, Sell)
    end.

sum_amounts(Tree) ->
    lists:sum(gb_trees:values(Tree)).
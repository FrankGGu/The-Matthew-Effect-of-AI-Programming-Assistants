-module(solution).
-export([get_number_of_orders/1]).

-define(MOD, 1000000007).

get_number_of_orders(Orders) ->
    {FinalBuyBacklog, FinalSellBacklog} = process_all_orders(Orders, gb_trees:empty(), gb_trees:empty()),
    TotalBuyAmount = sum_tree_amounts(FinalBuyBacklog),
    TotalSellAmount = sum_tree_amounts(FinalSellBacklog),
    (TotalBuyAmount + TotalSellAmount) rem ?MOD.

process_all_orders([], BuyBacklog, SellBacklog) ->
    {BuyBacklog, SellBacklog};
process_all_orders([[Price, Amount, 0] | Rest], BuyBacklog, SellBacklog) -> % Buy order
    {RemainingBuyAmount, NewSellBacklog} = process_buy_order(Price, Amount, SellBacklog),
    NewBuyBacklog = update_backlog_tree(BuyBacklog, Price, RemainingBuyAmount),
    process_all_orders(Rest, NewBuyBacklog, NewSellBacklog);
process_all_orders([[Price, Amount, 1] | Rest], BuyBacklog, SellBacklog) -> % Sell order
    {RemainingSellAmount, NewBuyBacklog} = process_sell_order(Price, Amount, BuyBacklog),
    NewSellBacklog = update_backlog_tree(SellBacklog, Price, RemainingSellAmount),
    process_all_orders(Rest, NewBuyBacklog, NewSellBacklog).

process_buy_order(BuyPrice, BuyAmount, SellBacklog) ->
    process_buy_order_loop(BuyPrice, BuyAmount, SellBacklog).

process_buy_order_loop(BuyPrice, BuyAmount, SellBacklog) ->
    if BuyAmount == 0 or gb_trees:is_empty(SellBacklog) ->
        {BuyAmount, SellBacklog};
    else
        {{SellPrice, SellAmount}, TempSellBacklog} = gb_trees:take_smallest(SellBacklog),
        if SellPrice =< BuyPrice ->
            MatchedAmount = min(BuyAmount, SellAmount),
            NewBuyAmount = BuyAmount - MatchedAmount,
            NewSellAmount = SellAmount - MatchedAmount,
            UpdatedSellBacklog = if NewSellAmount > 0 -> gb_trees:insert(SellPrice, NewSellAmount, TempSellBacklog);
                                 else -> TempSellBacklog
                                 end,
            process_buy_order_loop(BuyPrice, NewBuyAmount, UpdatedSellBacklog);
        else % No more matches possible as lowest sell price is too high
            UpdatedSellBacklog = gb_trees:insert(SellPrice, SellAmount, TempSellBacklog), % Put back the taken order
            {BuyAmount, UpdatedSellBacklog}
        end
    end.

process_sell_order(SellPrice, SellAmount, BuyBacklog) ->
    process_sell_order_loop(SellPrice, SellAmount, BuyBacklog).

process_sell_order_loop(SellPrice, SellAmount, BuyBacklog) ->
    if SellAmount == 0 or gb_trees:is_empty(BuyBacklog) ->
        {SellAmount, BuyBacklog};
    else
        {{BuyPrice, BuyAmount}, TempBuyBacklog} = gb_trees:take_largest(BuyBacklog),
        if BuyPrice >= SellPrice ->
            MatchedAmount = min(SellAmount, BuyAmount),
            NewSellAmount = SellAmount - MatchedAmount,
            NewBuyAmount = BuyAmount - MatchedAmount,
            UpdatedBuyBacklog = if NewBuyAmount > 0 -> gb_trees:insert(BuyPrice, NewBuyAmount, TempBuyBacklog);
                                else -> TempBuyBacklog
                                end,
            process_sell_order_loop(SellPrice, NewSellAmount, UpdatedBuyBacklog);
        else % No more matches possible as highest buy price is too low
            UpdatedBuyBacklog = gb_trees:insert(BuyPrice, BuyAmount, TempBuyBacklog), % Put back the taken order
            {SellAmount, UpdatedBuyBacklog}
        end
    end.

update_backlog_tree(Tree, Price, AmountToAdd) ->
    case gb_trees:lookup(Price, Tree) of
        {value, CurrentAmount} ->
            NewAmount = CurrentAmount + AmountToAdd,
            if NewAmount =< 0 -> gb_trees:delete(Price, Tree);
               true -> gb_trees:update(Price, NewAmount, Tree)
            end;
        _ -> % Price not in tree
            if AmountToAdd > 0 -> gb_trees:insert(Price, AmountToAdd, Tree);
               true -> Tree % Do nothing if trying to add non-positive amount to non-existent key
            end
    end.

sum_tree_amounts(Tree) ->
    lists:foldl(fun(Amount, Acc) -> Acc + Amount end, 0, gb_trees:values(Tree)).
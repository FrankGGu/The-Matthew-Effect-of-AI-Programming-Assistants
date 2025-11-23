-module(solution).
-export([get_number_of_backlog_orders/1]).

-type order() :: {Price :: integer(), Amount :: integer(), OrderType :: integer()}.

-spec get_number_of_backlog_orders(Orders :: [[integer()]]) -> integer().
get_number_of_backlog_orders(Orders) ->
    Buy = gb_trees:empty(),
    Sell = gb_trees:empty(),
    process_orders(Orders, Buy, Sell).

process_orders([], Buy, Sell) ->
    TotalBuy = lists:foldl(fun({_, Amount}, Acc) -> (Acc + Amount) rem 1000000007 end, 0, gb_trees:values(Buy)),
    TotalSell = lists:foldl(fun({_, Amount}, Acc) -> (Acc + Amount) rem 1000000007 end, 0, gb_trees:values(Sell)),
    (TotalBuy + TotalSell) rem 1000000007;
process_orders([[Price, Amount, OrderType] | Rest], Buy, Sell) ->
    case OrderType of
        0 -> process_buy_order(Price, Amount, Rest, Buy, Sell);
        1 -> process_sell_order(Price, Amount, Rest, Buy, Sell)
    end.

process_buy_order(Price, Amount, Rest, Buy, Sell) ->
    case gb_trees:is_empty(Sell) of
        true ->
            NewBuy = update_tree(Buy, Price, Amount),
            process_orders(Rest, NewBuy, Sell);
        false ->
            {MinSellPrice, {MinSellAmount, _}} = gb_trees:smallest(Sell),
            case Price >= MinSellPrice of
                true ->
                    case Amount >= MinSellAmount of
                        true ->
                            NewAmount = Amount - MinSellAmount,
                            NewSell = gb_trees:delete(MinSellPrice, Sell),
                            process_buy_order(Price, NewAmount, Rest, Buy, NewSell);
                        false ->
                            NewMinSellAmount = MinSellAmount - Amount,
                            NewSell = gb_trees:update(MinSellPrice, {NewMinSellAmount, 0}, Sell),
                            process_orders(Rest, Buy, NewSell)
                    end;
                false ->
                    NewBuy = update_tree(Buy, Price, Amount),
                    process_orders(Rest, NewBuy, Sell)
            end
    end.

process_sell_order(Price, Amount, Rest, Buy, Sell) ->
    case gb_trees:is_empty(Buy) of
        true ->
            NewSell = update_tree(Sell, Price, Amount),
            process_orders(Rest, Buy, NewSell);
        false ->
            {MaxBuyPrice, {MaxBuyAmount, _}} = gb_trees:largest(Buy),
            case Price <= MaxBuyPrice of
                true ->
                    case Amount >= MaxBuyAmount of
                        true ->
                            NewAmount = Amount - MaxBuyAmount,
                            NewBuy = gb_trees:delete(MaxBuyPrice, Buy),
                            process_sell_order(Price, NewAmount, Rest, NewBuy, Sell);
                        false ->
                            NewMaxBuyAmount = MaxBuyAmount - Amount,
                            NewBuy = gb_trees:update(MaxBuyPrice, {NewMaxBuyAmount, 0}, Buy),
                            process_orders(Rest, NewBuy, Sell)
                    end;
                false ->
                    NewSell = update_tree(Sell, Price, Amount),
                    process_orders(Rest, Buy, NewSell)
            end
    end.

update_tree(Tree, Price, Amount) ->
    case gb_trees:lookup(Price, Tree) of
        {value, {ExistingAmount, _}} ->
            NewAmount = ExistingAmount + Amount,
            gb_trees:update(Price, {NewAmount, 0}, Tree);
        none ->
            gb_trees:insert(Price, {Amount, 0}, Tree)
    end.
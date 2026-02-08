-module(maximum_profit).
-export([maximum_profit/2]).

maximum_profit(Prices, Discounts) ->
    maximum_profit(Prices, Discounts, 0, 0, 0, length(Prices)).

maximum_profit(_Prices, _Discounts, Index, Profit, UsedDiscount, Len) when Index >= Len ->
    Profit;
maximum_profit(Prices, Discounts, Index, Profit, UsedDiscount, Len) ->
    Price = lists:nth(Index + 1, Prices),
    Discount = lists:nth(Index + 1, Discounts),

    Case1 = maximum_profit(Prices, Discounts, Index + 1, Profit, UsedDiscount, Len),

    Case2 = maximum_profit(Prices, Discounts, Index + 1, Profit + Price, UsedDiscount, Len),

    case UsedDiscount of
        0 ->
            Case3 = maximum_profit(Prices, Discounts, Index + 1, Profit + Price - Discount, 1, Len),
            max([Case1, Case2, Case3]);
        1 ->
            max([Case1, Case2])
    end.

max([X, Y]) ->
    if X > Y -> X;
       true -> Y
    end.

max([X, Y, Z]) ->
    max([X, max([Y, Z])]).
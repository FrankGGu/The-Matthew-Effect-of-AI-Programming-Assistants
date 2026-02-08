-module(solution).
-export([max_profit/2]).

max_profit(Inventory, Orders) ->
    Sorted = lists:sort(fun(A, B) -> B =< A end, Inventory),
    {Profit, _} = calculate(Sorted, Orders, 0),
    Profit rem 1000000007.

calculate(Inv, Orders, Profit) when Orders =< 0 ->
    {Profit, Inv};
calculate([H | T], Orders, Profit) ->
    case T of
        [] ->
            Next = 0;
        [Next | _] ->
            Next
    end,
    MaxSell = H - Next,
    if
        MaxSell =< 0 ->
            calculate(T, Orders, Profit);
        true ->
            Count = length([H | lists:takewhile(fun(X) -> X == H end, T)]) + 1,
            CanSell = min(MaxSell * Count, Orders),
            Full = CanSell div Count,
            Partial = CanSell rem Count,
            NewH = H - Full,
            NewProfit = Profit + sum(H, NewH) * Count + NewH * Partial,
            NewOrders = Orders - CanSell,
            NewInv = lists:sort(fun(A, B) -> B =< A end, [NewH || _ <- lists:seq(1, Count - Partial)] ++ [NewH - 1 || _ <- lists:seq(1, Partial)] ++ lists:nthtail(Count, [H | T])),
            calculate(NewInv, NewOrders, NewProfit)
    end.

sum(High, Low) ->
    (High * (High + 1) div 2 - Low * (Low + 1) div 2).
-module(sell_diminishing_valued_colored_balls).
-export([maxProfit/1]).

maxProfit(Inventory) ->
    maxProfit(Inventory, 0).

maxProfit(Inventory, Acc) ->
    SortedInventory = lists:sort(fun(A, B) -> A > B end, Inventory),
    case SortedInventory of
        [] ->
            Acc;
        [MaxVal] ->
            N = 1,
            case canSell(SortedInventory, 1, MaxVal - 1, 1) of
                {true, NumToSell} ->
                    Profit = (MaxVal + (MaxVal - NumToSell + 1)) * NumToSell div 2,
                    (Acc + Profit) rem 1000000007;
                _ ->
                    Acc
            end;
        [MaxVal | Rest] ->
            case length(Rest) of
                0 ->
                    N = 1;
                _ ->
                    N = 1
            end,

            case canSell(SortedInventory, 1, SortedInventory !! 1, N) of
                {true, NumToSell} ->
                    Profit = (MaxVal + (MaxVal - NumToSell + 1)) * NumToSell div 2,
                    NewInventory = [MaxVal - NumToSell | Rest],
                    maxProfit(NewInventory, (Acc + Profit) rem 1000000007);
                {false, _} ->
                    NumToSell = MaxVal - SortedInventory !! 1,
                    Profit = (MaxVal + (MaxVal - NumToSell + 1)) * NumToSell div 2,
                    NewInventory = [SortedInventory !! 1 | Rest],
                    maxProfit(NewInventory, (Acc + Profit) rem 1000000007)

            end
    end.

canSell(Inventory, MaxOrders, LowerBound, N) ->
    canSell(Inventory, MaxOrders, LowerBound, 0, N).

canSell([H | T], MaxOrders, LowerBound, Acc, N) ->
    case H - LowerBound >= MaxOrders of
        true ->
            {true, MaxOrders};
        false ->
            case (H - LowerBound) * N + Acc >= MaxOrders of
                true ->
                    {true, MaxOrders - Acc};
                false ->
                    canSell(T, MaxOrders, LowerBound, Acc + (H - LowerBound) * N, N)
            end
    end;
canSell([], MaxOrders, LowerBound, Acc, N) ->
    {false, Acc}.
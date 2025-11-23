-module(solution).
-export([accountBalanceAfterPurchase/1]).

accountBalanceAfterPurchase(PurchaseAmount) ->
    LastDigit = PurchaseAmount rem 10,
    RoundedAmount =
        if
            LastDigit >= 5 ->
                PurchaseAmount + (10 - LastDigit);
            true ->
                PurchaseAmount - LastDigit
        end,
    100 - RoundedAmount.
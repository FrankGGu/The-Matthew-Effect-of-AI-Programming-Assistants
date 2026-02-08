-spec account_balance_after_purchase(PurchaseAmount :: integer()) -> integer().
account_balance_after_purchase(PurchaseAmount) ->
    InitialBalance = 100,
    Remainder = PurchaseAmount rem 10,
    if
        Remainder < 5 -> 
            RoundedAmount = PurchaseAmount - Remainder;
        true -> 
            RoundedAmount = PurchaseAmount + (10 - Remainder)
    end,
    InitialBalance - RoundedAmount.
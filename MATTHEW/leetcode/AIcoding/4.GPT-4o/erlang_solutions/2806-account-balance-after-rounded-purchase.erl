-module(solution).
-export([account_balance_after_purchase/2]).

account_balance_after_purchase(AccountBalance, PurchaseAmount) ->
    NewBalance = AccountBalance - round(PurchaseAmount),
    NewBalance.
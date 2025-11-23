-module(account_balance).
-export([account_balance_after_rounded_purchase/1]).

account_balance_after_rounded_purchase(PurchaseAmount) ->
    Rounded = round(PurchaseAmount / 10.0) * 10,
    100 - Rounded.
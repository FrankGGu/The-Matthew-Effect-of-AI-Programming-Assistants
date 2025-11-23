-module(account_balance_after_rounded_purchase).
-export([get_modified_balance/1]).

get_modified_balance(Balance) ->
    get_modified_balance(Balance, 0).

get_modified_balance(0, Acc) ->
    Acc;
get_modified_balance(Balance, Acc) ->
    Price = math:floor(Balance / 2),
    NewBalance = Balance - Price,
    get_modified_balance(NewBalance, Acc + Price).
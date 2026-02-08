-module(minimum_money_required_before_transactions).
-export([minimumMoney/1]).

minimumMoney(Transactions) ->
    lists:foldl(fun({Amount, _}, Acc) -> Acc + Amount end, 0, Transactions).
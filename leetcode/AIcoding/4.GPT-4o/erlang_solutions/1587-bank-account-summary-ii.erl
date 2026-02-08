-module(solution).
-export([bank_account_summary/1]).

bank_account_summary(Accounts) ->
    TotalBalance = lists:foldl(fun({_, Balance}, Acc) -> Acc + Balance end, 0, Accounts),
    MaxBalance = lists:max(lists:map(fun({_, Balance}) -> Balance end, Accounts)),
    MinBalance = lists:min(lists:map(fun({_, Balance}) -> Balance end, Accounts)),
    {TotalBalance, MinBalance, MaxBalance}.
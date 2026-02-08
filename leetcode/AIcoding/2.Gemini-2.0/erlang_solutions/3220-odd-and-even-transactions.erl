-module(solution).
-export([solve/1]).

solve(Transactions) ->
    OddTransactions = [T || {Id, Amount, Timestamp} <- Transactions, Amount rem 2 /= 0],
    EvenTransactions = [T || {Id, Amount, Timestamp} <- Transactions, Amount rem 2 =:= 0],
    {length(OddTransactions), length(EvenTransactions)}.
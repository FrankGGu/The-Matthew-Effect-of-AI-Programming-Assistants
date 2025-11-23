-module(bank_account_summary_ii).
-export([account_summary/0]).

account_summary() ->
    Users = [{1, "Will", 2}, {2, "Jane", 4}, {3, "Alex", 5}, {4, "Mason", 100}, {5, "Adam", 1}],
    Transactions = [
        {1, 101, 1000},
        {2, 102, 1000},
        {3, 103, 1000},
        {4, 104, 1000},
        {5, 105, 1000},
        {1, 102, 200},
        {2, 103, 300},
        {3, 104, 400},
        {4, 105, 500},
        {5, 101, 600},
        {1, 103, 700},
        {2, 104, 800},
        {3, 105, 900},
        {4, 101, 100},
        {5, 102, 200}
    ],
    UserMap = maps:from_list([{Id, Name} || {Id, Name, _} <- Users]),
    TransactionMap = maps:from_list([{UserId, []} || {UserId, _, _} <- Users]),
    AccTransactions = lists:foldl(fun({UserId, TxId, Amount}, Acc) ->
        case maps:get(UserId, Acc, []) of
            [] -> maps:put(UserId, [Amount], Acc);
            List -> maps:put(UserId, [Amount | List], Acc)
        end
    end, TransactionMap, Transactions),
    Results = lists:map(fun({UserId, Name}) ->
        Total = lists:sum(maps:get(UserId, AccTransactions, [])),
        {UserId, Name, Total}
    end, Users),
    lists:sort(fun({A, _, _}, {B, _, _}) -> A < B end, Results).
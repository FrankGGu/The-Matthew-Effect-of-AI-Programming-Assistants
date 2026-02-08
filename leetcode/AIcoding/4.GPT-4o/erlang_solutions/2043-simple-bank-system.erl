-module(simple_bank).
-export([new/1, deposit/3, withdraw/3, transfer/4, check_balance/2]).

-record(account, {balance = 0}).

new(N) ->
    Accounts = lists:duplicate(N, #account{}),
    {ok, Accounts}.

deposit(AccountList, AccountId, Amount) ->
    case lists:nth(AccountId + 1, AccountList) of
        Account when Amount >= 0 -> 
            NewAccount = Account#account{balance = Account#account.balance + Amount},
            NewAccountList = lists:replace(AccountId + 1, NewAccount, AccountList),
            {ok, NewAccountList};
        _ -> 
            {error, invalid_account}
    end.

withdraw(AccountList, AccountId, Amount) ->
    case lists:nth(AccountId + 1, AccountList) of
        Account when Amount >= 0, Account#account.balance >= Amount -> 
            NewAccount = Account#account{balance = Account#account.balance - Amount},
            NewAccountList = lists:replace(AccountId + 1, NewAccount, AccountList),
            {ok, NewAccountList};
        _ -> 
            {error, insufficient_funds}
    end.

transfer(AccountList, FromId, ToId, Amount) ->
    case withdraw(AccountList, FromId, Amount) of
        {ok, NewAccountList} ->
            case deposit(NewAccountList, ToId, Amount) of
                {ok, FinalAccountList} -> {ok, FinalAccountList};
                {error, _} -> {error, transfer_failed}
            end;
        {error, _} -> {error, transfer_failed}
    end.

check_balance(AccountList, AccountId) ->
    case lists:nth(AccountId + 1, AccountList) of
        Account -> Account#account.balance;
        _ -> {error, invalid_account}
    end.
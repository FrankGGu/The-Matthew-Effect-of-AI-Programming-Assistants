-module(bank).
-export([init/1, transfer/4, deposit/3, withdraw/3]).

init(Balance) ->
    {ok, Balance}.

transfer(From, To, Amount, Balance) ->
    case lists:keyfind(From, 1, Balance) of
        false -> {error, "From account does not exist"};
        {From, FromBalance} when FromBalance >= Amount ->
            case lists:keyfind(To, 1, Balance) of
                false -> {error, "To account does not exist"};
                {To, ToBalance} ->
                    NewBalance1 = lists:keyreplace(From, 1, Balance, {From, FromBalance - Amount}),
                    NewBalance2 = lists:keyreplace(To, 1, NewBalance1, {To, ToBalance + Amount}),
                    {ok, NewBalance2}
            end;
        _ -> {error, "Insufficient balance"}
    end.

deposit(Account, Amount, Balance) ->
    case lists:keyfind(Account, 1, Balance) of
        false -> {error, "Account does not exist"};
        {Account, AccountBalance} ->
            NewBalance = lists:keyreplace(Account, 1, Balance, {Account, AccountBalance + Amount}),
            {ok, NewBalance}
    end.

withdraw(Account, Amount, Balance) ->
    case lists:keyfind(Account, 1, Balance) of
        false -> {error, "Account does not exist"};
        {Account, AccountBalance} when AccountBalance >= Amount ->
            NewBalance = lists:keyreplace(Account, 1, Balance, {Account, AccountBalance - Amount}),
            {ok, NewBalance};
        _ -> {error, "Insufficient balance"}
    end.
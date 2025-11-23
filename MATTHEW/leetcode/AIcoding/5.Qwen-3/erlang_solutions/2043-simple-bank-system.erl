-module(bank_system).
-export([new/0, transfer/3, deposit/2, withdraw/2, balance/1]).

new() ->
    dict:new().

transfer(From, To, Amount) ->
    case balance(From) of
        {ok, Bal} when Bal >= Amount ->
            NewBalFrom = Bal - Amount,
            NewBalTo = balance(To) + Amount,
            dict:store(From, NewBalFrom, dict:store(To, NewBalTo, dict:fetch(From, dict:new()))),
            ok;
        _ ->
            error
    end.

deposit(Account, Amount) ->
    case balance(Account) of
        {ok, Bal} ->
            dict:store(Account, Bal + Amount, dict:fetch(Account, dict:new())),
            ok;
        _ ->
            error
    end.

withdraw(Account, Amount) ->
    case balance(Account) of
        {ok, Bal} when Bal >= Amount ->
            dict:store(Account, Bal - Amount, dict:fetch(Account, dict:new())),
            ok;
        _ ->
            error
    end.

balance(Account) ->
    case dict:find(Account, dict:new()) of
        {ok, Bal} ->
            {ok, Bal};
        _ ->
            error
    end.
-module(bank).
-export([new/1, transfer/4, deposit/3, withdraw/3]).

new(BalanceList) ->
    InitialMap = list_to_map(BalanceList, 1, #{}),
    spawn(fun() -> loop(InitialMap) end).

transfer(BankPid, Account1, Account2, Money) ->
    BankPid ! {transfer, Account1, Account2, Money, self()},
    receive
        Result -> Result
    end.

deposit(BankPid, Account, Money) ->
    BankPid ! {deposit, Account, Money, self()},
    receive
        Result -> Result
    end.

withdraw(BankPid, Account, Money) ->
    BankPid ! {withdraw, Account, Money, self()},
    receive
        Result -> Result
    end.

loop(BalancesMap) ->
    receive
        {transfer, From, To, Money, CallerPid} ->
            {Result, NewBalancesMap} = handle_transfer(From, To, Money, BalancesMap),
            CallerPid ! Result,
            loop(NewBalancesMap);
        {deposit, Account, Money, CallerPid} ->
            {Result, NewBalancesMap} = handle_deposit(Account, Money, BalancesMap),
            CallerPid ! Result,
            loop(NewBalancesMap);
        {withdraw, Account, Money, CallerPid} ->
            {Result, NewBalancesMap} = handle_withdraw(Account, Money, BalancesMap),
            CallerPid ! Result,
            loop(NewBalancesMap);
        _ ->
            loop(BalancesMap)
    end.

handle_transfer(From, To, Money, BalancesMap) ->
    case maps:is_key(From, BalancesMap) andalso maps:is_key(To, BalancesMap) of
        true ->
            FromBalance = maps:get(From, BalancesMap),
            case FromBalance >= Money of
                true ->
                    NewFromBalance = FromBalance - Money,
                    NewToBalance = maps:get(To, BalancesMap) + Money,
                    UpdatedBalances = BalancesMap#{From := NewFromBalance, To := NewToBalance},
                    {true, UpdatedBalances};
                false ->
                    {false, BalancesMap}
            end;
        false ->
            {false, BalancesMap}
    end.

handle_deposit(Account, Money, BalancesMap) ->
    case maps:is_key(Account, BalancesMap) of
        true ->
            CurrentBalance = maps:get(Account, BalancesMap),
            NewBalance = CurrentBalance + Money,
            UpdatedBalances = BalancesMap#{Account := NewBalance},
            {true, UpdatedBalances};
        false ->
            {false, BalancesMap}
    end.

handle_withdraw(Account, Money, BalancesMap) ->
    case maps:is_key(Account, BalancesMap) of
        true ->
            CurrentBalance = maps:get(Account, BalancesMap),
            case CurrentBalance >= Money of
                true ->
                    NewBalance = CurrentBalance - Money,
                    UpdatedBalances = BalancesMap#{Account := NewBalance},
                    {true, UpdatedBalances};
                false ->
                    {false, BalancesMap}
            end;
        false ->
            {false, BalancesMap}
    end.

list_to_map([], _Idx, AccMap) -> AccMap;
list_to_map([H|T], Idx, AccMap) ->
    list_to_map(T, Idx + 1, maps:put(Idx, H, AccMap)).
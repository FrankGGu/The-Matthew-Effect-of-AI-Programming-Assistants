-module(bank).
-export([start/1, deposit/2, withdraw/2, transfer/3, get_balance/1]).

start(Balance) ->
  spawn(fun() -> loop(Balance) end).

deposit(Pid, Account, Amount) ->
  Pid ! {deposit, Account, Amount, self()},
  receive
    {deposit_reply, Result} ->
      Result
  end.

withdraw(Pid, Account, Amount) ->
  Pid ! {withdraw, Account, Amount, self()},
  receive
    {withdraw_reply, Result} ->
      Result
  end.

transfer(Pid, Account1, Account2, Amount) ->
  Pid ! {transfer, Account1, Account2, Amount, self()},
  receive
    {transfer_reply, Result} ->
      Result
  end.

get_balance(Pid, Account) ->
  Pid ! {get_balance, Account, self()},
  receive
    {balance_reply, Balance} ->
      Balance
  end.

loop(Balance) ->
  receive
    {deposit, Account, Amount, Caller} ->
      case lists:nth(Account - 1, Balance) of
        undefined ->
          Caller ! {deposit_reply, false},
          loop(Balance);
        OldBalance ->
          NewBalance = OldBalance + Amount,
          NewBalanceList = lists:replace(Account - 1, NewBalance, Balance),
          Caller ! {deposit_reply, true},
          loop(NewBalanceList)
      end;
    {withdraw, Account, Amount, Caller} ->
      case lists:nth(Account - 1, Balance) of
        undefined ->
          Caller ! {withdraw_reply, false},
          loop(Balance);
        OldBalance ->
          if OldBalance >= Amount then
            NewBalance = OldBalance - Amount,
            NewBalanceList = lists:replace(Account - 1, NewBalance, Balance),
            Caller ! {withdraw_reply, true},
            loop(NewBalanceList)
          else
            Caller ! {withdraw_reply, false},
            loop(Balance)
          end
      end;
    {transfer, Account1, Account2, Amount, Caller} ->
      case lists:nth(Account1 - 1, Balance) of
        undefined ->
          Caller ! {transfer_reply, false},
          loop(Balance);
        Balance1 ->
          case lists:nth(Account2 - 1, Balance) of
            undefined ->
              Caller ! {transfer_reply, false},
              loop(Balance);
            Balance2 ->
              if Balance1 >= Amount then
                NewBalance1 = Balance1 - Amount,
                NewBalance2 = Balance2 + Amount,
                NewBalanceList1 = lists:replace(Account1 - 1, NewBalance1, Balance),
                NewBalanceList2 = lists:replace(Account2 - 1, NewBalance2, NewBalanceList1),
                Caller ! {transfer_reply, true},
                loop(NewBalanceList2)
              else
                Caller ! {transfer_reply, false},
                loop(Balance)
              end
          end
      end;
    {get_balance, Account, Caller} ->
      case lists:nth(Account - 1, Balance) of
        undefined ->
          Caller ! {balance_reply, -1},
          loop(Balance);
        AccountBalance ->
          Caller ! {balance_reply, AccountBalance},
          loop(Balance)
      end
  end.
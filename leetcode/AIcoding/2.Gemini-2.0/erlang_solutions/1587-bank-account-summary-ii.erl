-module(bank_account_summary_ii).
-export([solve/1]).

solve(Transactions) ->
  Accounts = lists:foldl(
    fun({AccountId, Amount}, Acc) ->
      case maps:is_key(AccountId, Acc) of
        true ->
          maps:update(AccountId, maps:get(AccountId, Acc) + Amount, Acc);
        false ->
          maps:put(AccountId, Amount, Acc)
      end
    end,
    #{},
    Transactions
  ),

  FilteredAccounts = maps:filter(
    fun(_AccountId, Balance) ->
      Balance > 10000
    end,
    Accounts
  ),

  lists:map(
    fun({AccountId, Balance}) ->
      {AccountId, Balance}
    end,
    maps:to_list(FilteredAccounts)
  ).
-module(richest_customer_wealth).
-export([maximum_wealth/1]).

maximum_wealth(Accounts) ->
  lists:max([lists:sum(Account) || Account <- Accounts]).
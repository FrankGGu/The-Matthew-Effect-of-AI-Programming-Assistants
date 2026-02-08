-module(solution).
-export([maximumWealth/1]).

maximumWealth(Accounts) ->
    CustomerWealths = lists:map(fun(CustomerAccounts) -> lists:sum(CustomerAccounts) end, Accounts),
    lists:max(CustomerWealths).
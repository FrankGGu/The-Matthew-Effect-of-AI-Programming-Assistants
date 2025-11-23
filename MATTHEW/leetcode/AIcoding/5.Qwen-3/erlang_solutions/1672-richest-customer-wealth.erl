-module(solution).
-export([maximum_wealth/1]).

maximum_wealth(Accounts) ->
    lists:max([lists:sum(A) || A <- Accounts]).
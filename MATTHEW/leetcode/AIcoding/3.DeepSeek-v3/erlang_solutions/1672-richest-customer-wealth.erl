-spec maximum_wealth(Accounts :: [[integer()]]) -> integer().
maximum_wealth(Accounts) ->
    lists:max([lists:sum(Account) || Account <- Accounts]).
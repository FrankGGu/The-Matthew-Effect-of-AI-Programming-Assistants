-spec minimum_money(Transactions :: [[integer()]]) -> integer().
minimum_money(Transactions) ->
    {TotalLoss, MaxCost} = lists:foldl(fun([cost, cashback], {Loss, Max}) ->
        NewLoss = Loss + max(0, cost - cashback),
        NewMax = max(Max, min(cost, cashback)),
        {NewLoss, NewMax}
    end, {0, 0}, Transactions),
    TotalLoss + MaxCost.
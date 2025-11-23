-spec mice_and_cheese(Reward1 :: [integer()], Reward2 :: [integer()], K :: integer()) -> integer().
mice_and_cheese(Reward1, Reward2, K) ->
    TotalReward2 = lists:sum(Reward2),
    Differences = lists:zipwith(fun(R1, R2) -> R1 - R2 end, Reward1, Reward2),
    SortedDifferencesDesc = lists:reverse(lists:sort(Differences)),
    TopKDifferences = lists:sublist(SortedDifferencesDesc, K),
    SumTopKDifferences = lists:sum(TopKDifferences),
    TotalReward2 + SumTopKDifferences.
-spec maximum_score(Nums :: [integer()], K :: integer()) -> integer().
maximum_score(Nums, K) ->
    maximum_score(Nums, K, 0, length(Nums) - 1, 0).

maximum_score(_, _, Left, Right, Max) when Left > Right -> Max;
maximum_score(Nums, K, Left, Right, Max) ->
    Min = lists:min(lists:sublist(Nums, Left + 1, Right - Left + 1)),
    CurrentScore = Min * (Right - Left + 1),
    NewMax = max(Max, CurrentScore),
    case (Left < K) andalso ((Right =< K) orelse (lists:nth(Left + 1, Nums) > lists:nth(Right + 1, Nums))) of
        true -> maximum_score(Nums, K, Left + 1, Right, NewMax);
        false -> maximum_score(Nums, K, Left, Right - 1, NewMax)
    end.
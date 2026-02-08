-spec find_prefix_scores(Nums :: [integer()]) -> [integer()].
find_prefix_scores(Nums) ->
    {Scores, _Max, _Sum} = lists:foldl(fun(N, {Acc, Max, Sum}) ->
        NewMax = max(Max, N),
        NewSum = Sum + N + NewMax,
        {Acc ++ [NewSum], NewMax, NewSum}
    end, {[], 0, 0}, Nums),
    Scores.
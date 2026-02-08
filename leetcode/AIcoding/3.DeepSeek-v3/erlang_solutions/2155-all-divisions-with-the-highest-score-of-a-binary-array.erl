-spec max_score_indices(Nums :: [integer()]) -> [integer()].
max_score_indices(Nums) ->
    TotalOnes = lists:sum(Nums),
    {MaxIndices, _, _} = lists:foldl(fun(Num, {Indices, MaxScore, LeftZeros}) ->
        RightOnes = TotalOnes - (LeftZeros + Num),
        CurrentScore = LeftZeros + RightOnes,
        if
            CurrentScore > MaxScore ->
                {[0], CurrentScore, LeftZeros + (1 - Num)};
            CurrentScore == MaxScore ->
                {[0 | Indices], MaxScore, LeftZeros + (1 - Num)};
            true ->
                {Indices, MaxScore, LeftZeros + (1 - Num)}
        end
    end, {[], 0, 0}, [0 | Nums]),
    lists:reverse([Index + 1 || Index <- MaxIndices]).
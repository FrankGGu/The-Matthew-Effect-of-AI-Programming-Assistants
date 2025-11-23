-spec majority_element(Nums :: [integer()]) -> [integer()].
majority_element(Nums) ->
    Count1 = 0,
    Count2 = 0,
    Candidate1 = 0,
    Candidate2 = 0,
    {FinalCount1, FinalCount2, FinalCandidate1, FinalCandidate2} = 
        lists:foldl(fun(Num, {C1, C2, Can1, Can2}) ->
            if
                Num =:= Can1 -> {C1 + 1, C2, Can1, Can2};
                Num =:= Can2 -> {C1, C2 + 1, Can1, Can2};
                C1 =:= 0 -> {1, C2, Num, Can2};
                C2 =:= 0 -> {C1, 1, Can1, Num};
                true -> {C1 - 1, C2 - 1, Can1, Can2}
            end
        end, {Count1, Count2, Candidate1, Candidate2}, Nums),

    Verify = fun(Candidate, List) ->
        length([X || X <- List, X =:= Candidate]) > length(List) div 3
    end,

    Result = [],
    Result1 = if
        Verify(FinalCandidate1, Nums) -> [FinalCandidate1 | Result];
        true -> Result
    end,
    Result2 = if
        FinalCandidate2 =/= FinalCandidate1 andalso Verify(FinalCandidate2, Nums) -> 
            [FinalCandidate2 | Result1];
        true -> Result1
    end,
    lists:reverse(Result2).
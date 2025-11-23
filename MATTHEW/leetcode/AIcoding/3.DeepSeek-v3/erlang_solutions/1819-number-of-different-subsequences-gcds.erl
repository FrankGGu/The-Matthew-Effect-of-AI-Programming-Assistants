-spec count_different_subsequence_gcds(Nums :: [integer()]) -> integer().
count_different_subsequence_gcds(Nums) ->
    Max = lists:max(Nums),
    Present = lists:foldl(fun(X, Acc) -> Acc#{X => true} end, #{}, Nums),
    Count = 0,
    {Result, _} = lists:foldl(
        fun(X, {Cnt, GcdMap}) ->
            NewGcdMap = maps:new(),
            case maps:is_key(X, Present) of
                true -> 
                    NewGcdMap1 = maps:put(X, true, NewGcdMap),
                    NewCnt = Cnt + 1,
                    {NewCnt, NewGcdMap1};
                false -> 
                    {Cnt, NewGcdMap}
            end,
            NewGcdMap2 = maps:fold(
                fun(G, _, AccIn) ->
                    NewG = gcd(G, X),
                    case maps:is_key(NewG, AccIn) of
                        true -> AccIn;
                        false -> 
                            case maps:is_key(NewG, Present) of
                                true -> 
                                    maps:put(NewG, true, AccIn);
                                false -> 
                                    AccIn
                            end
                    end
                end,
                NewGcdMap,
                GcdMap
            ),
            NewCnt2 = Cnt + maps:size(NewGcdMap2) - maps:size(NewGcdMap),
            {NewCnt2, NewGcdMap2}
        end,
        {Count, maps:new()},
        lists:seq(1, Max)
    ),
    Result.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).
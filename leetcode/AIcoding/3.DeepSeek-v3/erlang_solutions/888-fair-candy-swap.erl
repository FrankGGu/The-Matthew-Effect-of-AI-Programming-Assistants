-spec fair_candy_swap(AliceSizes :: [integer()], BobSizes :: [integer()]) -> [integer()].
fair_candy_swap(AliceSizes, BobSizes) ->
    SumA = lists:sum(AliceSizes),
    SumB = lists:sum(BobSizes),
    Delta = (SumB - SumA) div 2,
    BobSet = sets:from_list(BobSizes),
    {X, _} = lists:foldl(fun(A, Acc) ->
        B = A + Delta,
        case sets:is_element(B, BobSet) of
            true -> {A, B};
            false -> Acc
        end
    end, {0, 0}, AliceSizes),
    [X, X + Delta].
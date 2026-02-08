-spec k_items_with_maximum_sum(NumOnes :: integer(), NumZeros :: integer(), NumNegOnes :: integer(), K :: integer()) -> integer().
k_items_with_maximum_sum(NumOnes, NumZeros, NumNegOnes, K) ->
    Ones = min(NumOnes, K),
    Remaining = K - Ones,
    if 
        Remaining =< 0 -> Ones;
        true ->
            Zeros = min(NumZeros, Remaining),
            Remaining2 = Remaining - Zeros,
            if
                Remaining2 =< 0 -> Ones;
                true -> Ones - Remaining2
            end
    end.
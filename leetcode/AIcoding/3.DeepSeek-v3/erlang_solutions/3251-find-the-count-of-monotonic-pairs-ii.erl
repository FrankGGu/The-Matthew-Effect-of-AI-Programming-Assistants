-spec count_monotonic_pairs(Nums :: [integer()]) -> integer().
count_monotonic_pairs(Nums) ->
    {Count, _} = lists:foldl(fun(X, {Acc, Prev}) ->
        case X of
            X when X =< Prev ->
                {Acc + 1, X};
            _ ->
                {Acc, X}
        end
    end, {0, hd(Nums)}, tl(Nums)),
    Count.
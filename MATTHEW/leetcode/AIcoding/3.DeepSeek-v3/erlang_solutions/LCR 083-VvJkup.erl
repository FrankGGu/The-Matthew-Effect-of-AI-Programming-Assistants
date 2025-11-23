-spec permute(Nums :: [integer()]) -> [[integer()]].
permute(Nums) ->
    permute(Nums, length(Nums), []).

permute(_, 0, Acc) ->
    [Acc];
permute(Nums, K, Acc) ->
    lists:foldl(fun(X, Res) ->
        case lists:member(X, Acc) of
            true -> Res;
            false -> Res ++ permute(Nums, K - 1, [X | Acc])
        end
    end, [], Nums).
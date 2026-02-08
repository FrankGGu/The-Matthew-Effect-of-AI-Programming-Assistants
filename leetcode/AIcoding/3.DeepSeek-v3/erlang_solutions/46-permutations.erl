-spec permute(Nums :: [integer()]) -> [[integer()]].
permute(Nums) ->
    permute(Nums, length(Nums), []).

permute(_, 0, Acc) ->
    [Acc];
permute(Nums, K, Acc) ->
    lists:append([permute(lists:sublist(Nums, I - 1) ++ lists:nthtail(I, Nums), K - 1, [lists:nth(I, Nums) | Acc]) || I <- lists:seq(1, length(Nums))]).
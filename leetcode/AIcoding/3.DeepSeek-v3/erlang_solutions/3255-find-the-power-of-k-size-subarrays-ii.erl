-spec power_of_subarrays(Nums :: [integer()], K :: integer()) -> [integer()].
power_of_subarrays(Nums, K) ->
    N = length(Nums),
    Power = lists:duplicate(N - K + 1, 0),
    lists:reverse(lists:foldl(fun(I, Acc) ->
        Subarray = lists:sublist(Nums, I, K),
        Product = lists:foldl(fun(X, Prod) -> X * Prod end, 1, Subarray),
        [Product | Acc]
    end, [], lists:seq(1, N - K + 1))).
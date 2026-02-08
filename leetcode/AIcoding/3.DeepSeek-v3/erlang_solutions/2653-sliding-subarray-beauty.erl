-spec sliding_subarray_beauty(Nums :: [integer()], K :: integer(), X :: integer()) -> [integer()].
sliding_subarray_beauty(Nums, K, X) ->
    sliding_subarray_beauty(Nums, K, X, [], 0).

sliding_subarray_beauty([], _, _, Acc, _) ->
    lists:reverse(Acc);
sliding_subarray_beauty(Nums, K, X, Acc, Index) when Index + K > length(Nums) ->
    lists:reverse(Acc);
sliding_subarray_beauty(Nums, K, X, Acc, Index) ->
    Subarray = lists:sublist(Nums, Index + 1, K),
    Sorted = lists:sort(Subarray),
    Nth = lists:nth(X, Sorted),
    NewAcc = if
        Nth < 0 -> [Nth | Acc];
        true -> [0 | Acc]
    end,
    sliding_subarray_beauty(Nums, K, X, NewAcc, Index + 1).
-spec shortest_subarray(Nums :: [integer()], K :: integer()) -> integer().
shortest_subarray(Nums, K) ->
    case lists:any(fun(X) -> X >= K end, Nums) of
        true -> 1;
        false ->
            find_shortest(Nums, K, 2, length(Nums))
    end.

find_shortest(_, _, Len, MaxLen) when Len > MaxLen -> -1;
find_shortest(Nums, K, Len, MaxLen) ->
    case check_len(Nums, K, Len) of
        true -> Len;
        false -> find_shortest(Nums, K, Len + 1, MaxLen)
    end.

check_len(Nums, K, Len) ->
    lists:any(fun(I) ->
        Subarray = lists:sublist(Nums, I, Len),
        lists:foldl(fun(X, Acc) -> Acc bor X end, 0, Subarray) >= K
    end, lists:seq(1, length(Nums) - Len + 1)).